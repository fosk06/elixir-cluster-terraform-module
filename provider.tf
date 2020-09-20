# https://www.terraform.io/docs/providers/google/index.html
provider "google" {
  project = var.gcp_project
  region  = var.region
  zone    = var.default_zone
}
# https://www.terraform.io/docs/providers/google/provider_versions.html
provider "google-beta" {
  project = var.gcp_project
  region  = var.region
  zone    = var.default_zone
}

