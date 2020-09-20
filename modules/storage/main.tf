resource "google_storage_bucket" "artifacts" {
  description = "GCP bucket to store VM startup/shutdown script and elixir releases"
  name          = var.gcp_bucket_name
  location      = var.gcp_region
  force_destroy = true
  bucket_policy_only = true
}

resource "google_storage_bucket_object" "startup_script" {
  description = "VM startup script, deploy the elixir release and register GCP service directory endpoint"
  name   = "instance-startup.sh"
  source = "instance-startup.sh"
  bucket = google_storage_bucket.artifacts.name
}

resource "google_storage_bucket_object" "shutdown_script" {
  description = "VM shutdown script, unregister GCP service directory endpoint"
  name   = "instance-shutdown.sh"
  source = "instance-shutdown.sh"
  bucket = google_storage_bucket.artifacts.name
}