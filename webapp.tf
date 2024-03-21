resource "google_compute_instance" "webapp_vm_instance" {
  name = var.webapp_name
  # project      = var.project_id
  zone         = var.zone
  machine_type = var.webapp_machine_type
  depends_on   = [google_compute_network.vpc_network]
  boot_disk {
    initialize_params {
      image = var.webapp_custom_image
      size  = var.webapp_disk_size
      type  = var.webapp_disk_type
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.webapp_subnet.id
    access_config {}
  }

  metadata = {
    db_name     = google_sql_database.webapp_database.name
    db_user     = google_sql_user.webapp_user.name
    db_password = random_password.webapp_password.result
    db_host     = google_sql_database_instance.cloudsql_instance.private_ip_address
  }

  metadata_startup_script = file("startWebApp.sh")

  service_account {
    email  = google_service_account.logging_account.email
    scopes = ["cloud-platform"]
  }

  tags = [var.webapp_network_tag]
}
