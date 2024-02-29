resource "google_sql_database_instance" "cloudsql_instance" {
  name                = var.cloudsql_instance_name
  region              = var.region
  project             = var.project_id
  database_version    = var.cloudsql_database_version
  deletion_protection = false
  depends_on          = [google_service_networking_connection.private_vpc_connection]
  settings {
    availability_type = var.cloudsql_availability_type
    tier              = var.cloudsql_tier
    disk_type         = var.cloudsql_disk_type
    disk_size         = var.cloudsql_disk_size
    backup_configuration {
      binary_log_enabled = true
      enabled            = true
    }
    ip_configuration {
      ipv4_enabled                                  = false
      private_network                               = google_compute_network.vpc_network.self_link
      enable_private_path_for_google_cloud_services = true
    }
  }
}

resource "google_sql_database" "webapp_database" {
  name     = var.cloudsql_database_name
  project  = var.project_id
  instance = google_sql_database_instance.cloudsql_instance.name
}

resource "random_password" "webapp_password" {
  length = 16
}

resource "google_sql_user" "webapp_user" {
  name     = var.cloudsql_user_name
  project  = var.project_id
  instance = google_sql_database_instance.cloudsql_instance.name
  password = random_password.webapp_password.result
}
