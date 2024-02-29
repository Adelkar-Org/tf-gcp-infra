# public ip for webapp
output "webapp_vm_instance_public_ip" {
  value = google_compute_instance.webapp_vm_instance.network_interface.0.access_config.0.nat_ip
}
