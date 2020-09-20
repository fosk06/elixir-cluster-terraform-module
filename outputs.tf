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
# SERVICE DIRECTORY OUTPUTS
# ---------------------------------------------------------------------------------------------------------------------

output "namespace_name" {
  description = "The GCP service directory namespace name"
  value       = module.elixir_service_directory.namespace_name
}

output "service_name" {
  description = "The private hostname where apps will be available (DNS A record)"
  value       = module.elixir_service_directory.service_name
}

output "dns_name" {
  description = "The private hostname where apps will be available (DNS A record)"
  value       = module.elixir_service_directory.dns_name
}

# ---------------------------------------------------------------------------------------------------------------------
# NETWORK OUTPUTS
# ---------------------------------------------------------------------------------------------------------------------

output "vpc_name" {
  value       = module.elixir_network.vpc_name
  description = "vpc name"
}

output "subnet_name" {
  value       = module.elixir_network.subnet_name
  description = "subnet name"
}