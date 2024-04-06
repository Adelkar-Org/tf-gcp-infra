resource "google_compute_region_backend_service" "default" {
  name                  = var.backend_service_name
  region                = var.region
  protocol              = var.backend_service_protocol
  port_name             = var.backend_service_port_name
  load_balancing_scheme = var.backend_service_load_balancing_scheme
  session_affinity      = var.backend_service_session_affinity
  timeout_sec           = var.backend_service_timeout_sec

  health_checks = [google_compute_region_health_check.default.id]

  backend {
    group           = google_compute_region_instance_group_manager.default.instance_group
    balancing_mode  = var.backend_service_balancing_mode
    capacity_scaler = 1.0
  }
}
