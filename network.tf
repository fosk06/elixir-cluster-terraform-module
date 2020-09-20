resource "google_compute_network" "ex_vpc" {
  name = "ex-vpc"
  description = "vpc for our elixir instances"
}

resource "google_compute_subnetwork" "cluster" {
  name          = "ex-cluster"
  ip_cidr_range = "10.2.0.0/16"
  region        = var.region
  network       = google_compute_network.ex_vpc.id
}

resource "google_compute_firewall" "ex_http" {
  name    = "ex-allow-http"
  network = google_compute_network.ex_vpc.name
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_tags = ["http-server"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "ex_https" {
  name    = "ex-allow-https"
  network = google_compute_network.ex_vpc.name
  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
  source_tags = ["https-server"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "ex_epmd" {
  name    = "ex-allow-epmd"
  description = "allow epmd default port and erlang port distribution"
  network = google_compute_network.ex_vpc.name
  allow {
    protocol = "tcp"
    ports    = ["4369", "4710-4720"]
  }
  source_tags = ["erlang-node"]
}

resource "google_compute_firewall" "ex_ssh" {
  name    = "ex-allow-ssh"
  network = google_compute_network.ex_vpc.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
}