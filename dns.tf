data "google_dns_managed_zone" "webapp_dns_zone" {
  name = var.dns_zone_name
}

# resource "google_dns_record_set" "a_record" {
#   name         = "adelkar.me."
#   type         = "A"
#   ttl          = 300
#   managed_zone = data.google_dns_managed_zone.webapp_dns_zone.name
#   rrdatas      = [google_compute_instance.webapp_vm_instance.network_interface.0.access_config.0.nat_ip]
#   project      = var.project_id
# }

resource "google_dns_record_set" "frontend" {
  project      = var.project_id
  name         = "adelkar.me."
  type         = "A"
  ttl          = 300
  managed_zone = data.google_dns_managed_zone.webapp_dns_zone.name //default
  rrdatas      = [google_compute_global_forwarding_rule.default.ip_address]
}
