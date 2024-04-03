resource "google_compute_region_instance_template" "template" {
  name         = "webapp-template"
  machine_type = var.webapp_machine_type
  region       = var.region

  disk {
    source_image = var.webapp_custom_image
    # auto_delete  = true
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
  name                = "webapp-health-check"
  description         = "Webapp health check via https"
  region              = var.region
  check_interval_sec  = 10
  timeout_sec         = 5
  healthy_threshold   = 3
  unhealthy_threshold = 5

  http_health_check {
    port         = 8080
    request_path = "/healthz"
  }
}

resource "google_compute_region_autoscaler" "default" {
  name   = "webapp-autoscaler"
  region = var.region
  target = google_compute_region_instance_group_manager.default.id

  autoscaling_policy {
    max_replicas    = 2 //var.max_replicas
    min_replicas    = 1 //var.min_replicas
    cooldown_period = 60

    cpu_utilization {
      target = 0.05 # 5% CPU usage
    }
  }

  depends_on = [google_compute_region_instance_group_manager.default]
}

resource "google_compute_region_instance_group_manager" "default" {
  name                      = "webapp-instance-group"
  region                    = var.region
  base_instance_name        = "webapp"
  target_size               = 1 //var.min_replicas
  distribution_policy_zones = [var.zone]

  version {
    instance_template = google_compute_region_instance_template.template.id
  }

  named_port {
    name = "http"
    port = 8080
  }

  auto_healing_policies {
    health_check      = google_compute_region_health_check.default.id
    initial_delay_sec = 300
  }

  depends_on = [google_compute_region_instance_template.template]
  # lifecycle {
  #   prevent_destroy = false
  # }
}


