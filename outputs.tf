# ---------------------------------------------------------------------------------------------------------------------
# STORAGE OUTPUTS
# ---------------------------------------------------------------------------------------------------------------------

output "bucket_url" {
  value       = module.elixir_storage.bucket_url
  description = "bucket url"
}

output "startup_script_url" {
  value       = module.elixir_storage.startup_script_url
  description = "startup script url"
}

output "shutdown_script_url" {
  value       = module.elixir_storage.shutdown_script_url
  description = "shutdown script url"
}


# ---------------------------------------------------------------------------------------------------------------------
# NETWORK OUTPUTS
# ---------------------------------------------------------------------------------------------------------------------

output "vpc_name" {
  value       = module.elixir_network.vpc_name
  description = "vpc name"
}

output "vpc_link" {
  value       = module.elixir_network.vpc_link
  description = "vpc link"
}

output "subnet_name" {
  value       = module.elixir_network.subnet_name
  description = "subnet name"
}

output "subnet_link" {
  value       = module.elixir_network.subnet_link
  description = "subnet self link"
}

output "service_namespace" {
  description = "The GCP service directory namespace name"
  value       = module.elixir_network.service_namespace
}

output "service_name" {
  description = "The private hostname where apps will be available (DNS A record)"
  value       = module.elixir_network.service_name
}

output "dns_name" {
  description = "The private hostname where apps will be available (DNS A record)"
  value       = module.elixir_network.dns_name
}

output "http_network_tags" {
  value       = module.elixir_network.http_network_tags
  description = "http tags"
}

output "https_network_tags" {
  value       = module.elixir_network.https_network_tags
  description = "https tags"
}

output "epmd_network_tags" {
  value       = module.elixir_network.epmd_network_tags
  description = "epmd tags"
}


output "service_account_email" {
  value       = google_service_account.elixir_cluster_service_account.email
  description = "service_account_email"
}