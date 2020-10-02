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

# ---------------------------------------------------------------------------------------------------------------------
# CREATE COMPUTE RESSOURCES
# ---------------------------------------------------------------------------------------------------------------------

module "elixir_compute" {
  gcp_project_id = var.gcp_project_id
  gcp_region  = var.gcp_region
  gcp_default_zone    = var.gcp_default_zone
  source = "./modules/compute"
  image = var.image
  machine_type = var.machine_type
  session_affinity = var.session_affinity
  disk_type = var.disk_type
  disk_size = var.disk_size
  vm_preemptible = var.vm_preemptible
  release_url = var.release_url
  secret_key_base = var.secret_key_base
  startup_script_url = module.elixir_storage.startup_script_url
  shutdown_script_url = module.elixir_storage.shutdown_script_url
  service_name = basename(module.elixir_network.service_name)
  service_namespace = basename(module.elixir_network.service_namespace)
  cluster_hostname = trimsuffix(module.elixir_network.dns_name,".")
  vpc_name = module.elixir_network.vpc_name
  service_account_email = google_service_account.elixir_cluster_service_account.email
  tags = setunion(
    module.elixir_network.http_network_tags,
    module.elixir_network.https_network_tags,
    module.elixir_network.epmd_network_tags
  )
  default_autoscaler = var.default_autoscaler
  default_autoscaler_target_cpu = var.default_autoscaler_target_cpu
  autoscaler_min_replicas    = var.autoscaler_min_replicas
  autoscaler_max_replicas    = var.autoscaler_max_replicas
  autoscaler_cooldown_period = var.autoscaler_cooldown_period

}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE IAM PERMISSIONS AND SERVICE ACCOUNT
# ---------------------------------------------------------------------------------------------------------------------


resource "google_service_account" "elixir_cluster_service_account" {
  project = var.gcp_project_id
  account_id   = "elixir-cluster"
  display_name = "elixir cluster"
}

resource "google_project_iam_binding" "elixir_cluster_storage_iam" {
    role    = "roles/storage.objectAdmin"
    members = [
        "serviceAccount:${google_service_account.elixir_cluster_service_account.email}"
    ]
}

resource "google_project_iam_binding" "elixir_cluster_logger_iam" {
    role    = "roles/logging.logWriter"
    members = [
        "serviceAccount:${google_service_account.elixir_cluster_service_account.email}"
    ]
}

resource "google_project_iam_binding" "elixir_cluster_servicedirectory_iam" {
    role    = "roles/servicedirectory.editor"
    members = [
        "serviceAccount:${google_service_account.elixir_cluster_service_account.email}"
    ]
}