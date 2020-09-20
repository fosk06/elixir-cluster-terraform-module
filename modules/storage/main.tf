resource "google_storage_bucket" "ex_build_artifacts" {
  name          = "ps_build_artifacts"
  location      = var.region
  force_destroy = true
  bucket_policy_only = true
}

resource "google_storage_bucket_object" "startup_script" {
  name   = "instance-startup.sh"
  source = "instance-startup.sh"
  bucket = google_storage_bucket.ex_build_artifacts.name
}

resource "google_storage_bucket_object" "shutdown_script" {
  name   = "instance-shutdown.sh"
  source = "instance-shutdown.sh"
  bucket = google_storage_bucket.ex_build_artifacts.name
}