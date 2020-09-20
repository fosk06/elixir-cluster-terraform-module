output "bucket_url" {
  value       = google_storage_bucket.artifacts.url
  description = "bucket url"
}

output "startup_script_url" {
  value       = "${google_storage_bucket.artifacts.url}/${google_storage_bucket_object.startup_script.name}"
  description = "startup script url"
}

output "shutdown_script_url" {
  value       = "${google_storage_bucket.artifacts.url}/${google_storage_bucket_object.shutdown_script.name}"
  description = "shutdown script url"
}

output "namespace_name" {
  value       = basename(google_service_directory_namespace.mycompany.name)
  description = "namespace name"
}

output "service_name" {
  value       = basename(google_service_directory_service.api.name)
  description = "service name"
}

output "dns_name" {
  description = "The private hostname where apps will be available (DNS A record)"
  value       = module.elixir_service_directory.dns_name
}