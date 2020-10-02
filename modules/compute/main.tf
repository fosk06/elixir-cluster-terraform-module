# ------------------------------------------------------------------------------
# CREATE VM TEMPLATE
# ------------------------------------------------------------------------------

resource "google_compute_instance_template" "elixir_application" {
  name_prefix  = "${var.service_name}-"
  machine_type = var.machine_type
  tags = var.tags
  labels = {
    environment = terraform.workspace
    langage = "elixir"
  }
  instance_description = "VM hosting the ${var.service_name} application"
  can_ip_forward = true

  scheduling {
    preemptible = var.vm_preemptible
    automatic_restart = !var.vm_preemptible
  }

  disk {
    boot = true
    auto_delete  = true
    source_image = "debian-cloud/debian-10"
    disk_type = var.disk_type
    disk_size_gb = var.disk_size
  }

  network_interface {
    network = var.vpc_name
    access_config {
        network_tier = "PREMIUM"
    }
  }
  
  lifecycle {
    create_before_destroy = true
  }

  metadata = {
    release-url = var.release_url
    startup-script-url = var.startup_script_url
    shutdown-script-url = var.shutdown_script_url
    secret-key-base = var.secret_key_base
    service-name = var.service_name
    service-namespace = var.service_namespace
    cluster-hostname = var.cluster_hostname
    region = var.gcp_region
  }

  service_account {
    email = var.service_account_email
    scopes = ["userinfo-email","cloud-platform"]
  }
  
}

# ------------------------------------------------------------------------------
# CREATE TARGET POOL
# ------------------------------------------------------------------------------

resource "google_compute_target_pool" "elixir_cluster" {
  provider         = google-beta
  name             = "${var.service_name}-target-pool"
  session_affinity = var.session_affinity
  # health_checks = [google_compute_http_health_check.default.self_link] # legacy health check
}

# ------------------------------------------------------------------------------
# CREATE INSTANCE GROUP MANAGER
# ------------------------------------------------------------------------------
resource "google_compute_instance_group_manager" "elixir_cluster" {
  name = "${var.service_name}-group-manager"

  base_instance_name = var.service_name
  zone = var.gcp_default_zone

  version {
    instance_template = google_compute_instance_template.elixir_application.self_link
  }
  target_pools = [google_compute_target_pool.elixir_cluster.self_link]
  # auto_healing_policies {
  #   health_check = google_compute_health_check.default.self_link
  #   initial_delay_sec = 300
  # }
  
  named_port {
    name = "http"
    port = 80
  }
  named_port {
    name = "https"
    port = 443
  }

  named_port {
    name = "epmd"
    port = 4369
  }

  depends_on = [google_compute_instance_template.elixir_application]
}

# ------------------------------------------------------------------------------
# CREATE AUTOSCALER
# ------------------------------------------------------------------------------

resource "google_compute_autoscaler" "elixir_cluster" {
  count = var.default_autoscaler ? 1 : 0
  provider = google-beta
  name   = "${var.service_name}-autoscaler"
  zone = var.gcp_default_zone
  target = google_compute_instance_group_manager.elixir_cluster.id

  autoscaling_policy {
    min_replicas    = var.autoscaler_min_replicas
    max_replicas    = var.autoscaler_max_replicas
    cooldown_period = var.autoscaler_cooldown_period

    cpu_utilization {
      target = var.default_autoscaler_target_cpu
    }
    
  }
}