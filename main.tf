# https://www.terraform.io/docs/providers/google/index.html
provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
  zone    = var.gcp_default_zone
}
# https://www.terraform.io/docs/providers/google/provider_versions.html
provider "google-beta" {
  project = var.gcp_project_id
  region  = var.gcp_region
  zone    = var.gcp_default_zone
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE NETWORK RESSOURCES
# ---------------------------------------------------------------------------------------------------------------------

module "elixir_network" {
  gcp_project_id = var.gcp_project_id
  gcp_region  = var.gcp_region
  gcp_default_zone    = var.gcp_default_zone
  source = "./modules/network"
  vpc_name = var.vpc_name
  subnet_name = var.subnet_name
  subnet_cidr_range = var.subnet_cidr_range
  namespace_name = var.namespace_name
  service_name = var.service_name
  dns_managed_zone_name = var.dns_managed_zone_name
  dns_managed_zone_dns_name = var.dns_managed_zone_dns_name
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE STORAGE RESSOURCES
# ---------------------------------------------------------------------------------------------------------------------

module "elixir_storage" {
  gcp_project_id = var.gcp_project_id
  gcp_region  = var.gcp_region
  gcp_default_zone    = var.gcp_default_zone
  source = "./modules/storage"
  gcp_bucket_name = var.gcp_bucket_name
    
}