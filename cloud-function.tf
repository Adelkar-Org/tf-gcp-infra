resource "random_id" "bucket_prefix" {
  byte_length = 8
}

resource "google_storage_bucket" "verify_email_gcf_source" {
  name                        = "${random_id.bucket_prefix.hex}-verify-email-gcf-source" # Every bucket name must be globally unique
  location                    = var.region
  uniform_bucket_level_access = true
  encryption {
    default_kms_key_name = google_kms_crypto_key.storage_key.id
  }
}

data "archive_file" "source_code" {
  type        = "zip"
  output_path = "/tmp/${var.gcf_source_bucket_object_name}"
  source_dir  = "serverless/"
}

resource "google_storage_bucket_object" "code" {
  name   = var.gcf_source_bucket_object_name
  bucket = google_storage_bucket.verify_email_gcf_source.name
  source = data.archive_file.source_code.output_path # Path to the zipped function source code
}

# create a vpc connector for cloud function to communicate with private Cloud SQL instance in the vpc
resource "google_vpc_access_connector" "gcf_connector" {
  name          = var.gcf_connector_name
  region        = var.region
  network       = google_compute_network.vpc_network.self_link
  ip_cidr_range = var.gcf_connector_ip_cidr_range
}

resource "google_cloudfunctions2_function" "verify_email" {
  name        = var.gcf_name
  location    = var.region
  description = var.gcf_description
  build_config {
    entry_point = var.gcf_entry_point
    runtime     = var.gcf_runtime
    # environment_variables = {
    #   BUILD_CONFIG_TEST = "build_test"
    # }
    source {
      storage_source {
        bucket = google_storage_bucket.verify_email_gcf_source.name
        object = google_storage_bucket_object.code.name
      }
    }
  }
  service_config {
    max_instance_count = var.gcf_config_max_instance_count
    min_instance_count = var.gcf_config_min_instance_count
    available_memory   = var.gcf_config_available_memory
    timeout_seconds    = var.gcf_config_timeout_seconds
    vpc_connector      = google_vpc_access_connector.gcf_connector.self_link
    environment_variables = {
      # SERVICE_CONFIG_TEST = "config_test"
      DB_HOST     = google_sql_database_instance.cloudsql_instance.private_ip_address
      DB_NAME     = google_sql_database.webapp_database.name
      DB_DIALECT  = var.cloudsql_database_dialect
      DB_USER     = google_sql_user.webapp_user.name
      DB_PASSWORD = random_password.webapp_password.result

      MAILGUN_API_KEY = var.mailgun_api_key
      MAILGUN_DOMAIN  = var.mailgun_domain
    }
    ingress_settings               = var.gcf_config_vpc_ingress_settings
    all_traffic_on_latest_revision = true
    service_account_email          = google_service_account.gcf_sa.email
  }
  event_trigger {
    trigger_region = var.region
    event_type     = var.gcf_config_event_trigger_event_type
    pubsub_topic   = google_pubsub_topic.verify_email.id
    retry_policy   = var.gcf_config_event_trigger_retry_policy
  }
  depends_on = [google_storage_bucket_object.code, google_vpc_access_connector.gcf_connector, google_pubsub_topic.verify_email]
}
