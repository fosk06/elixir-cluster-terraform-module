output "bucket_url" {
  value       = google_storage_bucket.ex_build_artifacts.url
  description = "bucket url"
}

output "startup_script_url" {
  value       = "${google_storage_bucket.ex_build_artifacts.url}/${google_storage_bucket_object.startup_script.name}"
  description = "startup script url"
}

output "shutdown_script_url" {
  value       = "${google_storage_bucket.ex_build_artifacts.url}/${google_storage_bucket_object.shutdown_script.name}"
  description = "shutdown script url"
}

output "namespace_name" {
  value       = basename(google_service_directory_namespace.prestashop.name)
  description = "namespace name"
}

output "service_name" {
  value       = basename(google_service_directory_service.api.name)
  description = "service name"
}
