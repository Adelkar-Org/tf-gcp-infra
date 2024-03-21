# resource "google_dns_managed_zone" "webapp_dns_zone" {
#   name        = "webapp-dns-zone"
#   dns_name    = "adelkar.me."
#   description = "webapp dns zone"
#   project     = var.project_id
# }

# resource "google_dns_record_set" "a_record" {
#   name         = "adelkar.me."
#   type         = "A"
#   ttl          = 300
#   managed_zone = google_dns_managed_zone.webapp_dns_zone.name
#   rrdatas      = [google_compute_instance.webapp_vm_instance.network_interface.0.access_config.0.nat_ip]
#   project      = var.project_id
# }

data "google_dns_managed_zone" "webapp_dns_zone" {
  name = "webapp-dns-zone"
}

resource "google_dns_record_set" "a_record" {
  name         = "adelkar.me."
  type         = "A"
  ttl          = 300
  managed_zone = data.google_dns_managed_zone.webapp_dns_zone.name
  rrdatas      = [google_compute_instance.webapp_vm_instance.network_interface.0.access_config.0.nat_ip]
  project      = var.project_id
}
