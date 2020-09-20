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