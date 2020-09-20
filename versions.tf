terraform {
  required_providers {
    docker = {
      source = "terraform-providers/docker"
    }
    google = {
      source = "hashicorp/google"
    }
    google-beta = {
      source = "hashicorp/google-beta"
    }
  }
  required_version = ">= 0.13"
}
