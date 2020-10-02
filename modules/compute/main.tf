locals {
  release_url = var.release_url
  startup_script_url = module.elixir_storage.startup_script_url
  shutdown_script_url = module.elixir_storage.shutdown_script_url
  secret_key_base = var.elixir_secret_key_base
  service_name = basename(module.elixir_network.service_name)
  service_namespace = basename(module.elixir_network.service_namespace)
  cluster_hostname = trimsuffix(module.elixir_network.dns_name,".")

  # VM tags for firewall rules
  tags = setunion(
    module.elixir_network.http_network_tags,
    module.elixir_network.https_network_tags,
    module.elixir_network.epmd_network_tags
  )
}

# ------------------------------------------------------------------------------
# CREATE VM TEMPLATE
# ------------------------------------------------------------------------------

resource "google_compute_instance_template" "template" {
  name_prefix  = var.elixir_application_name
  machine_type = var.machine_type
  tags = local.tags
  labels = {
    environment = terraform.workspace
    langage = "elixir"
  }
  instance_description = "VM hosting the ${var.elixir_application_name} application"
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
    network = module.elixir_network.vpc_name
    access_config {
        network_tier = "PREMIUM"
    }
  }
  
  lifecycle {
    create_before_destroy = true
  }

  metadata = {
    release-url = local.release_url
    startup-script-url = local.startup_script_url
    shutdown-script-url = local.shutdown_script_url
    secret-key-base = local.secret_key_base
    service-name = local.service_name
    service-namespace = local.service_namespace
    cluster-hostname = local.cluster_hostname
    region = var.gcp_region
  }

  service_account {
    email = google_service_account.elixir_cluster_service_account.email
    scopes = ["userinfo-email","cloud-platform"]
  }
  
}