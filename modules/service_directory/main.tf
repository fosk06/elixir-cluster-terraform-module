resource "google_service_directory_namespace" "mycompany" {
  provider     = google-beta
  namespace_id = "mycompany"
  location     = var.region

  labels = {
    langage = "elixir"
  }
}

resource "google_service_directory_service" "api" {
  provider   = google-beta
  service_id = "api"
  namespace  = google_service_directory_namespace.mycompany.id

  metadata = {
    stage  = "staging"
    region = var.region
  }
}

resource "google_dns_managed_zone" "mycompany_app" {
  provider = google-beta
  name        = "mycompany-app"
  dns_name    = "mycompany.app."
  description = "mycompany apps DNS"
  labels = {
    langage = "elixir"
  }
  
  visibility = "private"
  
  private_visibility_config {
    networks {
      network_url = google_compute_network.ex_vpc.id
    }
  }
  service_directory_config {
    namespace {
      namespace_url = google_service_directory_namespace.mycompany.id
    }
  }
  
}