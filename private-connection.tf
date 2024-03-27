resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.vpc_network.self_link
  service                 = var.private_vpc_connection_service
  reserved_peering_ranges = [google_compute_global_address.private_services_connection.name]
}
resource "google_compute_global_address" "private_services_connection" {
  name          = var.private_services_connection_name
  purpose       = var.private_services_connection_purpose
  address_type  = var.private_services_connection_address_type
  prefix_length = var.private_services_connection_prefix_length
  network       = google_compute_network.vpc_network.self_link
}

