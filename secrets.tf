resource "google_secret_manager_secret" "db_password" {
  secret_id = "db_password"
  labels = {
    label = "password"
  }
  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
}

resource "google_secret_manager_secret_version" "db_password" {
  secret      = google_secret_manager_secret.db_password.id
  secret_data = random_password.webapp_password.result
}


# db_host
resource "google_secret_manager_secret" "db_host" {
  secret_id = "db_host"
  labels = {
    label = "host"
  }
  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
}

resource "google_secret_manager_secret_version" "db_host" {
  secret      = google_secret_manager_secret.db_host.id
  secret_data = google_sql_database_instance.cloudsql_instance.private_ip_address
  depends_on  = [google_sql_database_instance.cloudsql_instance]
}
