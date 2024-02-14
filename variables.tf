variable "project_id" {
  description = "The GCP project ID"
  type        = string
  default     = "csye6225-cloud"
}

variable "region" {
  description = "The region where resources will be created"
  type        = string
  default     = "us-east1"
}
