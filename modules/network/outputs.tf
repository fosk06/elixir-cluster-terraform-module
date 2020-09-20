output "vpc_name" {
  value       = google_compute_network.elixir_vpc.name
  description = "vpc name"
}

output "subnet_name" {
  value       = google_compute_subnetwork.elixir_cluster.name
  description = "vpc name"
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