resource "google_compute_network" "vpc_network" {
  name                            = var.vpc_name
  auto_create_subnetworks         = false
  routing_mode                    = var.vpc_routing_mode
  delete_default_routes_on_create = true
}

resource "google_compute_subnetwork" "webapp_subnet" {
  name          = var.subnetwork1_name
  ip_cidr_range = var.subnetwork1_ip_cidr_range
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "db_subnet" {
  name          = var.subnetwork2_name
  ip_cidr_range = var.subnetwork2_ip_cidr_range
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_route" "webapp_route" {
  name             = var.route_name
  dest_range       = var.route_dest_range
  network          = google_compute_network.vpc_network.id
  next_hop_gateway = var.route_next_hop_gateway
}

resource "google_compute_firewall" "firewall" {
  name    = var.firewall_name
  network = google_compute_network.vpc_network.id

  allow {
    protocol = var.firewall_protocol
    ports    = [var.application_port]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["webapp"]
}

resource "google_compute_instance" "webapp_vm_instance" {
  name         = var.compute_instance
  machine_type = "e2-standard-2"
  zone         = var.zone
  depends_on   = [google_compute_network.vpc_network]

  boot_disk {
    initialize_params {
      image = var.custom_image
      size  = 100
      type  = "pd-balanced"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.webapp_subnet.id
    access_config {}
  }

  tags = ["webapp"]
}
