resource "google_storage_bucket" "artifacts" {
  name          = var.gcp_bucket_name
  location      = var.gcp_region
  force_destroy = true
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "startup_script" {
  name   = "instance-startup.sh"
  source = "${path.module}/instance-startup.sh"
  bucket = google_storage_bucket.artifacts.name
}

resource "google_storage_bucket_object" "shutdown_script" {
  name   = "instance-shutdown.sh"
  source = "./instance-shutdown.sh"
  bucket = google_storage_bucket.artifacts.name
}