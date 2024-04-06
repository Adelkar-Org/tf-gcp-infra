resource "google_compute_address" "default" {
  name         = var.webapp_address_name
  address_type = "EXTERNAL"
  network_tier = "STANDARD"
  region       = var.region
}

resource "google_compute_region_url_map" "default" {
  name            = var.webapp_url_map_name
  region          = var.region
  default_service = google_compute_region_backend_service.default.id
}

resource "google_compute_region_target_https_proxy" "default" {
  name             = var.https_proxy_name
  region           = var.region
  url_map          = google_compute_region_url_map.default.id
  ssl_certificates = [google_compute_region_ssl_certificate.default.id]
}

resource "google_compute_region_ssl_certificate" "default" {
  region      = var.region
  name        = var.ssl_certificate_name
  private_key = file("privatekey.txt")
  certificate = file("full_chain.crt")
}

resource "google_compute_forwarding_rule" "default" {
  name                  = var.forwarding_rule_name
  region                = var.region
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  port_range            = "443"
  network_tier          = "STANDARD"
  target                = google_compute_region_target_https_proxy.default.id
  network               = google_compute_network.vpc_network.name
  ip_address            = google_compute_address.default.address
  depends_on            = [google_compute_subnetwork.proxy_only_subnet]
}
