resource "google_pubsub_topic" "verify_email" {
  name                       = "verify_email"
  message_retention_duration = "604800s" # 7 days in seconds
}
