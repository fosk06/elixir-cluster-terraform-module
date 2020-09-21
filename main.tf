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

resource "google_service_account" "elixir_cluster_service_account" {
  account_id   = "elixir-cluster"
  display_name = "elixir cluster"
}

data "google_iam_policy" "elixir_cluster_service_account" {

  binding {
    role =  "roles/storage.objectAdmin"
    members = [
      "serviceAccount:${google_service_account.elixir_cluster_service_account.email}",
    ]
  }

  binding {
    role =  "roles/servicedirectory.editor"
    members = [
      "serviceAccount:${google_service_account.elixir_cluster_service_account.email}",
    ]
  }
}

resource "google_service_account_iam_member" "k8s_cluster_service_account_storage_object_viewer" {
  service_account_id = "${google_service_account.elixir_cluster_service_account.account_id}"
  role        = "roles/logging.logWriter"
  member      = "serviceAccount:${google_service_account.elixir_cluster_service_account.email}",
}

resource "google_service_account_iam_policy" "elixir_cluster_iam" {
  service_account_id = google_service_account.elixir_cluster_service_account.name
  policy_data        = data.google_iam_policy.elixir_cluster_service_account.policy_data
}