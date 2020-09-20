output "vpc_name" {
  value       = google_compute_network.elixir_vpc.name
  description = "vpc name"
}

output "subnet_name" {
  value       = google_compute_subnetwork.elixir_cluster.name
  description = "vpc name"
}