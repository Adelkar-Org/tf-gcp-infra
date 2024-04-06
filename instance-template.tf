resource "google_compute_region_instance_template" "template" {
  name         = var.webapp_template_name
  machine_type = var.webapp_machine_type
  region       = var.region

  disk {
    source_image = var.webapp_custom_image
    boot         = true
    disk_size_gb = var.webapp_disk_size
    disk_type    = var.webapp_disk_type
  }

  network_interface {
    network    = google_compute_network.vpc_network.self_link
    subnetwork = google_compute_subnetwork.webapp_subnet.id
    access_config {
      network_tier = "STANDARD"
    }
  }

  service_account {
    email  = google_service_account.vm_instance_account.email
    scopes = ["cloud-platform"]
  }

  metadata = {
    db_name     = google_sql_database.webapp_database.name
    db_user     = google_sql_user.webapp_user.name
    db_password = random_password.webapp_password.result
    db_host     = google_sql_database_instance.cloudsql_instance.private_ip_address
  }

  metadata_startup_script = file("start-webapp.sh")

  tags = [var.webapp_network_tag]

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_region_health_check" "default" {
  name                = var.health_check_name
  description         = var.health_check_description
  region              = var.region
  check_interval_sec  = var.check_interval_sec
  timeout_sec         = var.timeout_sec
  healthy_threshold   = var.healthy_threshold
  unhealthy_threshold = var.unhealthy_threshold

  http_health_check {
    port         = var.health_check_port
    request_path = var.health_check_request_path
  }
}

resource "google_compute_region_autoscaler" "default" {
  name   = var.autoscaler_name
  region = var.region
  target = google_compute_region_instance_group_manager.default.id

  autoscaling_policy {
    max_replicas    = var.max_replicas
    min_replicas    = var.min_replicas
    cooldown_period = var.cooldown_period

    cpu_utilization {
      target = var.cpu_utilization_target
    }
  }

  depends_on = [google_compute_region_instance_group_manager.default]
}

resource "google_compute_region_instance_group_manager" "default" {
  name                      = var.instance_group_name
  region                    = var.region
  base_instance_name        = var.base_instance_name
  target_size               = var.target_size
  distribution_policy_zones = [var.zone]

  version {
    instance_template = google_compute_region_instance_template.template.id
  }

  named_port {
    name = var.named_port_name
    port = var.named_port_port
  }

  auto_healing_policies {
    health_check      = google_compute_region_health_check.default.id
    initial_delay_sec = var.auto_healing_initial_delay_sec
  }

  depends_on = [google_compute_region_instance_template.template]
}


