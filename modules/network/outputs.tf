output "vpc_name" {
  value       = google_compute_network.elixir_vpc.name
  description = "vpc name"
}

output "subnet_name" {
  value       = google_compute_subnetwork.elixir_cluster.name
  description = "vpc name"
}

output "service_namespace" {
  value       = google_service_directory_namespace.elixir_application.name
  description = "service namespace name"
}

output "service_name" {
  value       = google_service_directory_service.elixir_application.name
  description = "service name"
}

output "dns_name" {
  value       = google_dns_managed_zone.elixir_application.dns_name
  description = "DNS zone name"
}

output "http_network_tags" {
  value       = google_compute_firewall.allow_http.source_tags
  description = "http tags"
}

output "https_network_tags" {
  value       = google_compute_firewall.allow_https.source_tags
  description = "https tags"
}

output "epmd_network_tags" {
  value       = google_compute_firewall.allow_epmd.source_tags
  description = "epmd tags"
}