resource "google_compute_firewall" "webapp_firewall" {
  name    = var.firewall_name
  network = google_compute_network.vpc_network.id
  allow {
    protocol = var.firewall_protocol
    ports    = [var.firewall_application_port, 22]
  }
  source_ranges = [google_compute_subnetwork.proxy_only_subnet.ip_cidr_range, var.firewall_source_range]
  target_tags   = [var.webapp_network_tag]
}

# deny ssh access to the webapp instances
# resource "google_compute_firewall" "deny_ssh" {
#   name    = "webapp-deny-ssh"
#   network = google_compute_network.vpc_network.id
#   allow {
#     protocol = "tcp"
#     ports    = ["22"]
#   }
#   source_ranges = [var.firewall_source_range]
#   target_tags   = [var.webapp_network_tag]
# }

resource "google_compute_firewall" "lb_to_instances" {
  name    = var.firewall_lb_name
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "tcp"
    ports    = [var.firewall_application_port]
  }

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  # target_tags   = [var.webapp_network_tag]
}
