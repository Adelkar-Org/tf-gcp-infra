resource "google_service_account" "logging_account" {
  account_id   = "logging-account"
  display_name = "Logging Account"
}

resource "google_project_iam_binding" "logging_admin" {
  project = var.project_id
  role    = "roles/logging.configWriter"

  members = [
    "serviceAccount:logging-account@${var.project_id}.iam.gserviceaccount.com",
  ]
}

resource "google_project_iam_binding" "monitoring_metric_writer" {
  project = var.project_id
  role    = "roles/monitoring.metricWriter"

  members = [
    "serviceAccount:logging-account@${var.project_id}.iam.gserviceaccount.com",
  ]
}
