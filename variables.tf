#  Project variables
variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The region where resources will be created"
  type        = string
  default     = "us-east1"
}

variable "zone" {
  description = "The zone where resources will be created"
  type        = string
  default     = "us-east1-b"
}

# VPC variables
variable "vpc_name" {
  description = "The name for the vpc"
  type        = string
  default     = "csye6225-vpc"
}

variable "vpc_routing_mode" {
  description = "The vpc routing mode"
  type        = string
  default     = "REGIONAL"
}

# Subnetwork variables
variable "subnetwork1_name" {
  description = "The name for subnetwork 1"
  type        = string
  default     = "webapp-subnet"
}

variable "subnetwork1_ip_cidr_range" {
  description = "The ip cidr range subnetwork 1"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnetwork2_name" {
  description = "The name for subnetwork 2"
  type        = string
  default     = "db-subnet"
}

variable "subnetwork2_ip_cidr_range" {
  description = "The ip cidr range subnetwork 2"
  type        = string
  default     = "10.0.2.0/24"
}

variable "subnetwork3_name" {
  description = "The name for subnetwork 3"
  type        = string
  default     = "proxy-only-subnet"
}

variable "subnetwork3_purpose" {
  description = "The purpose for subnetwork 3"
  type        = string
  default     = "REGIONAL_MANAGED_PROXY"
}

variable "subnetwork3_role" {
  description = "The role for subnetwork 3"
  type        = string
  default     = "ACTIVE"
}
variable "subnetwork3_ip_cidr_range" {
  description = "The ip cidr range subnetwork 2"
  type        = string
  default     = "10.0.4.0/24"
}

# Route variables
variable "route_name" {
  description = "The name for route"
  type        = string
  default     = "webapp-internet-route"
}

variable "route_dest_range" {
  description = "The route destination range"
  type        = string
  default     = "0.0.0.0/0"
}

variable "route_next_hop_gateway" {
  description = "The route_next_hop_gateway"
  type        = string
  default     = "default-internet-gateway"
}

# Firewall variables
variable "firewall_name" {
  description = "firewall_name"
  type        = string
  default     = "webapp-firewall"
}

variable "firewall_protocol" {
  description = "firewall_protocol"
  type        = string
  default     = "tcp"
}

variable "firewall_application_port" {
  description = "application_port"
  type        = string
  default     = "8080"
}

# Compute Engine variables
variable "webapp_name" {
  description = "compute_instance"
  type        = string
  default     = "webapp-instance"
}

variable "webapp_machine_type" {
  description = "webapp_machine_type"
  type        = string
  default     = "f1-micro"
}

variable "webapp_custom_image" {
  description = "custom_image"
  type        = string
  default     = "webapp-image-familly"
}

variable "webapp_disk_size" {
  description = "webapp_disk_size"
  type        = number
  default     = 100
}

variable "webapp_disk_type" {
  description = "webapp_disk_type"
  type        = string
  default     = "pd-balanced"
}

variable "firewall_source_range" {
  description = "firewall_source_range"
  type        = string
  default     = "0.0.0.0/0"
}
variable "webapp_network_tag" {
  description = "webapp_network_tag"
  type        = string
  default     = "webapp"
}

# private services connection variables
variable "private_services_connection_name" {
  description = "private_services_connection_name"
  type        = string
  default     = "private-services-connection"
}

variable "private_services_connection_purpose" {
  description = "private_services_connection_purpose"
  type        = string
  default     = "VPC_PEERING"
}

variable "private_services_connection_address_type" {
  description = "private_services_connection_address_type"
  type        = string
  default     = "INTERNAL"
}

variable "private_services_connection_prefix_length" {
  description = "private_services_connection_prefix_length"
  type        = number
  default     = 16
}

variable "private_vpc_connection_service" {
  description = "private_vpc_connection_service"
  type        = string
  default     = "servicenetworking.googleapis.com"
}

# Cloud SQL variables
variable "cloudsql_instance_name" {
  description = "The name of the Cloud SQL instance"
  type        = string
  default     = "cloudsql-instance"
}

variable "cloudsql_database_version" {
  description = "Database version for the Cloud SQL instance"
  type        = string
  default     = "MYSQL_8_0"
}
variable "cloudsql_database_dialect" {
  description = "Database dialect for the Cloud SQL instance"
  type        = string
  default     = "mysql"
}
variable "cloudsql_tier" {
  description = "The tier (machine type) for the Cloud SQL instance"
  type        = string
  default     = "db-f1-micro"
}

variable "cloudsql_availability_type" {
  description = "The availability type for the Cloud SQL instance"
  type        = string
  default     = "REGIONAL"
}

variable "cloudsql_disk_type" {
  description = "The disk type for the Cloud SQL instance"
  type        = string
  default     = "PD_SSD"
}

variable "cloudsql_disk_size" {
  description = "Disk size in GB for the Cloud SQL instance"
  type        = number
  default     = 100
}

variable "cloudsql_database_name" {
  description = "The name of the database"
  type        = string
  default     = "webapp"

}

variable "cloudsql_user_name" {
  description = "The name of the user"
  type        = string
  default     = "webapp"
}

# DNS variables
variable "dns_zone_name" {
  description = "The name of the DNS zone"
  type        = string
  default     = "webapp-dns-zone"
}

variable "dns_record_name" {
  description = "The name of the DNS record"
  type        = string
  default     = "adelkar.me."
}

# Logging variables
variable "logging_account_name" {
  description = "The name of the logging account"
  type        = string
  default     = "logging-account"
}

variable "logging_account_display_name" {
  description = "The display name of the logging account"
  type        = string
  default     = "Logging Account"
}

variable "logging_admin_role" {
  description = "The role for logging admin"
  type        = string
  default     = "roles/logging.admin"
}

variable "monitoring_metric_writer_role" {
  description = "The role for monitoring metric writer"
  type        = string
  default     = "roles/monitoring.metricWriter"
}

# pubsub variables 
variable "pubsub_topic_name" {
  description = "The name of the pubsub topic"
  type        = string
  default     = "verify_email"
}

variable "pubsub_topic_message_retention_duration" {
  description = "The message retention duration of the pubsub topic"
  type        = string
  default     = "604800s" # 7 days in seconds

}

# GCF bucket variables
variable "gcf_source_bucket_location" {
  description = "The location of the GCF source bucket"
  type        = string
  default     = "US"
}

variable "gcf_source_bucket_object_name" {
  description = "The name of the GCF source bucket object"
  type        = string
  default     = "function-source.zip"

}

variable "gcf_source_bucket_name" {
  description = "The name of the GCF source bucket"
  type        = string
  default     = "gcf-source-bucket"
}

# GCF connactor variables 
variable "gcf_connector_name" {
  description = "The name of the GCF connector"
  type        = string
  default     = "gcf-connector"
}

variable "gcf_connector_ip_cidr_range" {
  description = "The ip cidr range for the GCF connector"
  type        = string
  default     = "10.0.3.0/28"
}

# GCF service account variables
variable "gcf_sa_name" {
  description = "The name of the GCF service account"
  type        = string
  default     = "gcf-sa"
}

variable "gcf_sa_display_name" {
  description = "The display name of the GCF service account"
  type        = string
  default     = "GCF Service Account"
}

variable "pubsub_publisher_role" {
  description = "The role for pubsub publisher"
  type        = string
  default     = "roles/pubsub.publisher"
}

# service account variables
variable "vm_instance_account_name" {
  description = "The name of the VM instance service account"
  type        = string
  default     = "vm-instance-account"
}

variable "vm_instance_account_display_name" {
  description = "The display name of the VM instance service account"
  type        = string
  default     = "VM Instance Service Account"
}

variable "vm_instance_role" {
  description = "The role for the VM instance"
  type        = string
  default     = "roles/compute.instanceAdmin.v1"
}

# gcf variables
variable "gcf_name" {
  description = "The name of the GCF function"
  type        = string
  default     = "verify-email"
}
variable "gcf_description" {
  description = "The description of the GCF function"
  type        = string
  default     = "function to verify email by sending an verification code on email"
}

variable "gcf_entry_point" {
  description = "The entry point of the GCF function"
  type        = string
  default     = "verifyEmail"
}

variable "gcf_runtime" {
  description = "The runtime of the GCF function"
  type        = string
  default     = "nodejs20"
}

variable "gcf_config_max_instance_count" {
  description = "The max instance count of the GCF function"
  type        = number
  default     = 1
}

variable "gcf_config_min_instance_count" {
  description = "The min instance count of the GCF function"
  type        = number
  default     = 1
}

variable "gcf_config_available_memory" {
  description = "The available memory of the GCF function"
  type        = string
  default     = "256M"
}

variable "gcf_config_vpc_ingress_settings" {
  description = "The vpc ingress settings of the GCF function"
  type        = string
  default     = "ALLOW_INTERNAL_ONLY"

}

variable "gcf_config_timeout_seconds" {
  description = "The timeout seconds of the GCF function"
  type        = number
  default     = 60
}

# event_type
variable "gcf_config_event_trigger_event_type" {
  description = "The event type of the GCF function"
  type        = string
  default     = "google.cloud.pubsub.topic.v1.messagePublished"
}
variable "gcf_config_event_trigger_retry_policy" {
  description = "The retry policy of the GCF function"
  type        = string
  default     = "RETRY_POLICY_RETRY"
}

# gcf env variables
variable "mailgun_api_key" {
  description = "The Mailgun API key"
  type        = string
}

variable "mailgun_domain" {
  description = "The Mailgun domain"
  type        = string
  default     = "adelkar.me"
}
# loadbalancer variables



# backend service variables
variable "backend_service_balancing_mode" {
  description = "The balancing mode of the backend service"
  type        = string
  default     = "UTILIZATION"
}

variable "backend_service_name" {
  description = "The name of the backend service"
  type        = string
  default     = "webapp-backend-service"

}
variable "backend_service_protocol" {
  description = ""
  type        = string
  default     = "HTTP"

}
variable "backend_service_port_name" {
  description = ""
  type        = string
  default     = "http"

}
variable "backend_service_load_balancing_scheme" {
  description = ""
  type        = string
  default     = "EXTERNAL_MANAGED"

}
variable "backend_service_session_affinity" {
  description = ""
  type        = string
  default     = "NONE"

}
variable "backend_service_timeout_sec" {
  description = ""
  type        = number
  default     = 10

}


variable "webapp_address_name" {
  description = "The name of the external address"
  type        = string
  default     = "webapp-address"
}

variable "webapp_url_map_name" {
  description = "The name of the URL map"
  type        = string
  default     = "webapp-url-map"
}

variable "https_proxy_name" {
  description = "The name of the HTTPS proxy"
  type        = string
  default     = "webapp-https-proxy"
}

variable "ssl_certificate_name" {
  description = "The name of the SSL certificate"
  type        = string
  default     = "webapp-certificate"
}

variable "forwarding_rule_name" {
  description = "The name of the forwarding rule"
  type        = string
  default     = "webapp-https-forwarding-rule"
}


# google_compute_region_instance_template
variable "webapp_template_name" {
  description = "The name of the instance template"
  type        = string
  default     = "webapp-template"
}

# google_compute_region_health_check
variable "health_check_name" {
  description = "The name of the health check"
  type        = string
  default     = "webapp-health-check"
}

variable "health_check_description" {
  description = "The description of the health check"
  type        = string
  default     = "Webapp health check via http"

}

variable "check_interval_sec" {
  description = "The interval between health checks"
  type        = number
  default     = 10
}

variable "timeout_sec" {
  description = "The timeout for health checks"
  type        = number
  default     = 5
}

variable "healthy_threshold" {
  description = "The number of consecutive successful health checks"
  type        = number
  default     = 3
}

variable "unhealthy_threshold" {
  description = "The number of consecutive failed health checks"
  type        = number
  default     = 5
}

variable "health_check_port" {
  description = "The port for the health check"
  type        = number
  default     = 8080
}

variable "health_check_request_path" {
  description = "The path for the health check"
  type        = string
  default     = "/healthz"
}

variable "autoscaler_name" {
  description = "The name of the autoscaler"
  type        = string
  default     = "webapp-autoscaler"
}

variable "max_replicas" {
  description = "The maximum number of replicas"
  type        = number
  default     = 2
}

variable "min_replicas" {
  description = "The minimum number of replicas"
  type        = number
  default     = 1
}

variable "cooldown_period" {
  description = "The cooldown period"
  type        = number
  default     = 60
}

variable "cpu_utilization_target" {
  description = "The target CPU utilization"
  type        = number
  default     = 0.05
}

variable "instance_group_name" {
  description = "The name of the instance group"
  type        = string
  default     = "webapp-instance-group"
}

variable "base_instance_name" {
  description = "The base name for the instances"
  type        = string
  default     = "webapp"
}

variable "target_size" {
  description = "The target size for the instance group"
  type        = number
  default     = 1
}


variable "named_port_name" {
  description = "The name of the named port"
  type        = string
  default     = "http"
}

variable "named_port_port" {
  description = "The port for the named port"
  type        = number
  default     = 8080
}


variable "auto_healing_initial_delay_sec" {
  description = "The initial delay for auto healing"
  type        = number
  default     = 300
}

variable "firewall_lb_name" {
  description = "The name of the firewall for the load balancer"
  type        = string
  default     = "webapp-lb-to-instances"
}
