resource "google_compute_firewall" "webapp_firewall" {
  name    = var.firewall_name
  network = google_compute_network.vpc_network.id
  allow {
    protocol = var.firewall_protocol
    ports    = [var.firewall_application_port, 22]
  }
  source_ranges = [var.firewall_source_range]
  target_tags   = [var.webapp_network_tag]
}
resource "google_compute_firewall" "lb_to_instances" {
  name    = "webapp-lb-to-instances"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["35.191.0.0/16", "130.211.0.0/22"]
  target_tags   = ["webapp-backend"]
}
