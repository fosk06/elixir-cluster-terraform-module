# https://www.terraform.io/docs/providers/google/index.html
provider "google" {
  project = "prestashop-data-integration"
  region  = var.region
  zone    = var.default_zone
}
# https://www.terraform.io/docs/providers/google/provider_versions.html
provider "google-beta" {
  project = "prestashop-data-integration"
  region  = var.region
  zone    = var.default_zone
}

provider "docker" {
  host = "tcp://127.0.0.1:2376/"
}

