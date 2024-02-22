variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The region where resources will be created"
  type        = string
}

variable "zone" {
  description = "The zone where resources will be created"
  type        = string
}

variable "vpc_name" {
  description = "The name for the vpc"
  type        = string
}

variable "vpc_routing_mode" {
  description = "The vpc routing mode"
  type        = string
}

variable "subnetwork1_name" {
  description = "The name for subnetwork 1"
  type        = string
}

variable "subnetwork1_ip_cidr_range" {
  description = "The ip cidr range subnetwork 1"
  type        = string
}

variable "subnetwork2_name" {
  description = "The name for subnetwork 2"
  type        = string
}

variable "subnetwork2_ip_cidr_range" {
  description = "The ip cidr range subnetwork 2"
  type        = string
}

variable "route_name" {
  description = "The name for route"
  type        = string
}

variable "route_dest_range" {
  description = "The route destination range"
  type        = string
}

variable "route_next_hop_gateway" {
  description = "The route_next_hop_gateway"
  type        = string
}
variable "firewall_name" {
  description = "firewall_name"
  type        = string
}

variable "firewall_protocol" {
  description = "firewall_protocol"
  type        = string
}

variable "application_port" {
  description = "application_port"
  type        = string
}

variable "compute_instance" {
  description = "compute_instance"
  type        = string
}

variable "custom_image" {
  description = "custom_image"
  type        = string
}
