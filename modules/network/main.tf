# ---------------------------------------------------------------------------------------------------------------------
# CREATE NETWORK VPC/SUBNET
# ---------------------------------------------------------------------------------------------------------------------

resource "google_compute_network" "elixir_vpc" {
  name = var.vpc_name
  description = "vpc for elixir instances"
}

resource "google_compute_subnetwork" "elixir_cluster" {
  name          = var.subnet_name
  description = "subnet for elixir instances"
  ip_cidr_range = var.subnet_cidr_range
  region        = var.gcp_region
  network       = google_compute_network.elixir_vpc.id
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE FIREWALL RULES
# ---------------------------------------------------------------------------------------------------------------------


resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = google_compute_network.elixir_vpc.name
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_tags = ["http-server"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_https" {
  name    = "allow-https"
  network = google_compute_network.elixir_vpc.name
  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
  source_tags = ["https-server"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_epmd" {
  name    = "ex-allow-epmd"
  description = "allow epmd default port and erlang port distribution"
  network = google_compute_network.elixir_vpc.name
  allow {
    protocol = "tcp"
    ports    = ["4369", "4710-4720"]
  }
  source_tags = ["erlang-node"]
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.elixir_vpc.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
}