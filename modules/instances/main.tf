# locals {
#   release-url = "${google_storage_bucket.artifacts.url}/gcp-0.1.0.tar.gz"
#   release-name = "gcp"
#   release-version = "0.1.0"
#   startup-script-url = "${google_storage_bucket.artifacts.url}/${google_storage_bucket_object.startup_script.name}"
#   shutdown-script-url = "${google_storage_bucket.artifacts.url}/${google_storage_bucket_object.shutdown_script.name}"
#   secret-key-base = "XmOqDnVm3BYT2ymDmpSUf6JEvNzUXrNhIE5z9HqyxSuLPoHfzOcLZzDaJKyH9ib1"
#   service-name = basename(google_service_directory_service.api.name)
#   service-namespace = basename(google_service_directory_namespace.mycompany.name)

#   # VM tags for firewall rules
#   tags = setunion(
#     google_compute_firewall.allow_epmd.source_tags,
#     google_compute_firewall.allow_http.source_tags,
#     google_compute_firewall.allow_https.source_tags
#   )
# }

# # VM instances
# resource "google_compute_instance" "ex-instance" {
#   count = 2 // number of instances
#   name         = "ex-instance-${count.index}"
#   machine_type = var.machine
#   zone         = var.gcp_default_zone
#   tags = local.tags

#   boot_disk {
#     initialize_params {
#       image = var.image
#       type = "pd-ssd"
#       size = 100
#     }
#   }

#   network_interface {
#     network = google_compute_network.ex_vpc.name
#     subnetwork = google_compute_subnetwork.cluster.name

#     access_config {

#     }
    
#   }

#   metadata = {
#     release-url = local.release-url
#     release-name = local.release-name
#     release-version = local.release-version
#     startup-script-url = local.startup-script-url
#     shutdown-script-url = local.shutdown-script-url
#     secret-key-base = local.secret-key-base
#     service-name = local.service-name
#     service-namespace = local.service-namespace
#     region = vargcp_region
#     hash = var.hash
#   }

#   service_account {
#     email = "api-v2-storage@mycompany-data-integration.iam.gserviceaccount.com"
#     scopes = ["userinfo-email","cloud-platform"]
#   }

#   scheduling {
#     preemptible = true
#     automatic_restart = false
#   }
# }