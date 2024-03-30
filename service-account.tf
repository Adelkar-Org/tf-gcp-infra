resource "google_service_account" "gcf_sa" {
  account_id   = var.gcf_sa_name
  display_name = var.gcf_sa_display_name
  account_id   = "gcf-sa"
  display_name = "GFC Service Account"
}

resource "google_service_account" "logging_account" {
  account_id   = var.logging_account_name
  display_name = var.logging_account_display_name
}

resource "google_project_iam_binding" "logging_admin" {
  project = var.project_id
  role    = var.logging_admin_role
  members = [
    "serviceAccount:${google_service_account.logging_account.email}",
  ]
}

resource "google_project_iam_binding" "monitoring_metric_writer" {
  project = var.project_id
  role    = var.monitoring_metric_writer_role
  members = [
    "serviceAccount:${google_service_account.logging_account.email}",
  ]
}

resource "google_pubsub_topic_iam_binding" "publisher" {
  topic = google_pubsub_topic.verify_email.id
  role  = var.pubsub_publisher_role
  members = [
    "serviceAccount:${google_service_account.logging_account.email}",
  ]
}
