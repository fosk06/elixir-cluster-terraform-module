# https://www.terraform.io/docs/providers/google/index.html
provider "google" {
  project = var.gcp_project
  region  = vargcp_region
  zone    = var.gcp_default_zone
}
# https://www.terraform.io/docs/providers/google/provider_versions.html
provider "google-beta" {
  project = var.gcp_project
  region  = vargcp_region
  zone    = var.gcp_default_zone
}

module "elixir_network" {
    source = "./modules/network"
}