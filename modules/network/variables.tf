variable "gcp_project_id" {
  description = "gcp project id"
}

variable "gcp_region" {
  description = "Where the cluster will live"
}

variable "gcp_default_zone" {
  description = "GCP default zone"
}

variable "vpc_name" {
  type        = string
  description = "name of the vpc"
}

variable "subnet_name" {
  type        = string
  description = "name of the subnet"
}

variable "subnet_cidr_range" {
  type        = string
  description = "ip range of subnetwork"
  default = "10.2.0.0/16"
}


output "namespace_name" {
  value       = google_service_directory_namespace.elixir_application.namespace
  description = "service name"
}

output "service_name" {
  value       = google_service_directory_service.elixir_application.name
  description = "service name"
}

output "dns_name" {
  value       = google_dns_managed_zone.elixir_application.dns_name
  description = "DNS zone name"
}