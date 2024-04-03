resource "google_compute_address" "default" {
  name         = "webapp-address"
  address_type = "EXTERNAL"
  network_tier = "STANDARD"
  region       = var.region
}

# resource "google_compute_managed_ssl_certificate" "default" {
#   name = "webapp-ssl-cert"
#   managed {
#     domains = [var.dns_record_name]
#   }
# }

resource "google_compute_region_url_map" "default" {
  name            = "webapp-url-map"
  region          = var.region
  default_service = google_compute_region_backend_service.default.id
}

resource "google_compute_region_target_https_proxy" "default" {
  name             = "webapp-https-proxy"
  region           = var.region
  url_map          = google_compute_region_url_map.default.id
  ssl_certificates = [google_compute_region_ssl_certificate.default.id]
}

resource "google_compute_region_ssl_certificate" "default" {
  region      = var.region
  name        = "certificate"
  private_key = file("privatekey.txt")
  certificate = file("adelkar_me.crt")
}

resource "google_compute_forwarding_rule" "default" {
  name                  = "webapp-https-forwarding-rule"
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
