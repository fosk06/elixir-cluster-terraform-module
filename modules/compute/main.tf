# ------------------------------------------------------------------------------
# CREATE VM TEMPLATE
# ------------------------------------------------------------------------------

resource "google_compute_instance_template" "template" {
  name_prefix  = var.service_name
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

  boot_disk {
    initialize_params {
      image = var.image
      type = var.disk_type
      size = var.ssd_size
    }
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