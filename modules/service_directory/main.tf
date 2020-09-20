resource "google_service_directory_namespace" "elixir_application" {
  provider     = google-beta
  namespace_id = var.namespace_name
  location     = var.gcp_region

  labels = {
    langage = "elixir"
  }
}

resource "google_service_directory_service" "elixir_application" {
  provider   = google-beta
  service_id = var.service_name
  namespace  = google_service_directory_namespace.elixir_application.id

  metadata = {
    region = var.gcp_region
  }
}

resource "google_dns_managed_zone" "elixir_application" {
  provider = google-beta
  name        = var.dns_managed_zone_name
  dns_name    = var.dns_managed_zone_dns_name
  description = "elixir application apps DNS"
  labels = {
    langage = "elixir"
  }
  
  visibility = "private"
  
  private_visibility_config {
    networks {
      network_url = google_compute_network.elixir_vpc.id
    }
  }
  service_directory_config {
    namespace {
      namespace_url = google_service_directory_namespace.elixir_application.id
    }
  }
  
}