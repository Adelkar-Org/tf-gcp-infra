resource "google_sql_database_instance" "cloudsql_instance" {
  name = var.cloudsql_instance_name
  # provider            = google-beta
  region              = var.region
  project             = var.project_id
  database_version    = var.cloudsql_database_version
  deletion_protection = false
  encryption_key_name = google_kms_crypto_key.sql_key.id
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
      private_network                               = google_service_networking_connection.private_vpc_connection.network
      enable_private_path_for_google_cloud_services = true
    }
  }
  depends_on = [google_service_networking_connection.private_vpc_connection]
}

resource "google_sql_database" "webapp_database" {
  name       = var.cloudsql_database_name
  project    = var.project_id
  instance   = google_sql_database_instance.cloudsql_instance.name
  depends_on = [google_sql_database_instance.cloudsql_instance]
}

resource "random_password" "webapp_password" {
  length = 16
}

resource "google_sql_user" "webapp_user" {
  name       = var.cloudsql_user_name
  project    = var.project_id
  instance   = google_sql_database_instance.cloudsql_instance.name
  password   = random_password.webapp_password.result
  depends_on = [google_sql_database_instance.cloudsql_instance]
}
