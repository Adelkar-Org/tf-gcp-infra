resource "google_compute_region_backend_service" "default" {
  name                  = "webapp-backend-service"
  region                = var.region
  protocol              = "HTTPS"
  port_name             = "https" //http
  load_balancing_scheme = "EXTERNAL_MANAGED"
  session_affinity      = "NONE"
  timeout_sec           = 10

  health_checks = [google_compute_health_check.default.id]

  backend {
    group           = google_compute_region_instance_group_manager.default.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
}
