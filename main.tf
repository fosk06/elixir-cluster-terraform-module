# https://www.terraform.io/docs/providers/google/index.html
provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
  zone    = var.gcp_default_zone
}
# https://www.terraform.io/docs/providers/google/provider_versions.html
provider "google-beta" {
  project = var.gcp_project
  region  = var.gcp_region
  zone    = var.gcp_default_zone
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE NETWORK RESSOURCES
# ---------------------------------------------------------------------------------------------------------------------

module "elixir_network" {
    source = "./modules/network"
    vpc_name = var.vpc_name
    subnet_name = var.subnet_name
    subnet_cidr_range = var.subnet_cidr_range
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE STORAGE RESSOURCES
# ---------------------------------------------------------------------------------------------------------------------

module "elixir_storage" {
    source = "./modules/storage"
    gcp_bucket_name = var.gcp_bucket_name
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE SERVICE DIRECTORY RESSOURCES
# ---------------------------------------------------------------------------------------------------------------------

module "elixir_service_directory" {
    source = "./modules/service_directory"
    namespace_name = var.namespace_name
    service_name = var.service_name
    dns_managed_zone_name = var.dns_managed_zone_name
    dns_managed_zone_dns_name = var.dns_managed_zone_dns_name
}