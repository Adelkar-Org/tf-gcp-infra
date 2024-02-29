resource "google_compute_route" "webapp_route" {
  name             = var.route_name
  dest_range       = var.route_dest_range
  network          = google_compute_network.vpc_network.self_link
  next_hop_gateway = var.route_next_hop_gateway
}
