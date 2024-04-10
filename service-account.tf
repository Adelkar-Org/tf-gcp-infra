resource "google_service_account" "gcf_sa" {
  account_id   = var.gcf_sa_name
  display_name = var.gcf_sa_display_name
}
# create a service account for customer-managed encryption keys.
# resource "google_service_account" "kms_sa" {
#   account_id   = "cmek-sa" # var.kms_sa_name
#   display_name = "CMEK SA" # var.kms_sa_display_name
# }

resource "google_project_service_identity" "gcp_sa_cloud_sql" {
  project  = var.project_id
  provider = google-beta
  service  = "sqladmin.googleapis.com"
}

resource "google_kms_crypto_key_iam_binding" "crypto_key" {
  provider      = google-beta
  crypto_key_id = google_kms_crypto_key.sql_key.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"

  members = [
    "serviceAccount:${google_project_service_identity.gcp_sa_cloud_sql.email}",
    "serviceAccount:${google_service_account.vm_instance_account.email}",
  ]
}

resource "google_kms_crypto_key_iam_member" "crypto_key_iam_member" {
  crypto_key_id = google_kms_crypto_key.storage_key.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  # member        = "serviceAccount:service-${var.project_number}@gs-project-accounts.iam.gserviceaccount.com"
  member = "serviceAccount:service-243008312509@gs-project-accounts.iam.gserviceaccount.com"
}


resource "google_service_account" "vm_instance_account" {
  account_id   = var.vm_instance_account_name
  display_name = var.vm_instance_account_display_name
}

resource "google_project_iam_member" "vm_instance_member" {
  project = var.project_id
  role    = var.vm_instance_role
  member  = "serviceAccount:${google_service_account.vm_instance_account.email}"
}

resource "google_project_iam_binding" "logging_admin" {
  project = var.project_id
  role    = var.logging_admin_role
  members = [
    "serviceAccount:${google_service_account.vm_instance_account.email}",
  ]
}

resource "google_project_iam_binding" "monitoring_metric_writer" {
  project = var.project_id
  role    = var.monitoring_metric_writer_role
  members = [
    "serviceAccount:${google_service_account.vm_instance_account.email}",
  ]
}

resource "google_pubsub_topic_iam_binding" "publisher" {
  topic = google_pubsub_topic.verify_email.id
  role  = var.pubsub_publisher_role
  members = [
    "serviceAccount:${google_service_account.vm_instance_account.email}",
  ]
}
