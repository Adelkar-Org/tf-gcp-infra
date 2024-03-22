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

