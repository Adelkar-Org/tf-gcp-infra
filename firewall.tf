resource "google_compute_firewall" "firewall" {
  name    = var.firewall_name
  network = google_compute_network.vpc_network.id
  allow {
    protocol = var.firewall_protocol
    ports    = [var.firewall_application_port, 22]
  }
  source_ranges = [var.firewall_source_range]
  target_tags   = [var.webapp_network_tag]
}
