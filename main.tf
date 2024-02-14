# provider "google" {
#   project = var.project_id
#   region  = var.region
# }

resource "google_compute_network" "vpc_network" {
  name                    = "my-vpc"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "webapp" {
  name          = "webapp"
  ip_cidr_range = "10.0.1.0/24"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "db" {
  name          = "db"
  ip_cidr_range = "10.0.2.0/24"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_route" "webapp_route" {
  name             = "webapp-internet-route"
  dest_range       = "0.0.0.0/0"
  network          = google_compute_network.vpc_network.id
  next_hop_gateway = "default-internet-gateway"
}
