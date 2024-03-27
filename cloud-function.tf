resource "random_id" "bucket_prefix" {
  byte_length = 8
}

resource "google_storage_bucket" "verify_email_gcf_source" {
  name                        = "${random_id.bucket_prefix.hex}-verify-email-gcf-source" # Every bucket name must be globally unique
  location                    = "US"
  uniform_bucket_level_access = true
}

data "archive_file" "source_code" {
  type        = "zip"
  output_path = "/tmp/function-source.zip"
  source_dir  = "serverless/"
}

resource "google_storage_bucket_object" "code" {
  name   = "function-source.zip"
  bucket = google_storage_bucket.verify_email_gcf_source.name
  source = data.archive_file.source_code.output_path # Path to the zipped function source code
}

resource "google_cloudfunctions2_function" "verify_email" {
  name        = "verify-email"
  location    = "us-east1"
  description = "function to verify email by sending an verification code on email"
  build_config {
    entry_point = "verifyEmail"
    runtime     = "nodejs20"
    environment_variables = {
      BUILD_CONFIG_TEST = "build_test"
      # SENDGRID_API_KEY = var.sendgrid_api_key
      # EMAIL_FROM       = var.email_from
    }
    source {
      storage_source {
        bucket = google_storage_bucket.verify_email_gcf_source.name
        object = google_storage_bucket_object.code.name
      }
    }
  }
  service_config {
    max_instance_count = 1
    min_instance_count = 1
    available_memory   = "256M"
    timeout_seconds    = 60
    environment_variables = {
      SERVICE_CONFIG_TEST = "config_test"
    }
    ingress_settings               = "ALLOW_INTERNAL_ONLY"
    all_traffic_on_latest_revision = true
    service_account_email          = google_service_account.gcf_sa.email
  }
  event_trigger {
    trigger_region = "us-east1"
    event_type     = "google.cloud.pubsub.topic.v1.messagePublished"
    pubsub_topic   = google_pubsub_topic.verify_email.id
    retry_policy   = "RETRY_POLICY_RETRY"
  }
}
