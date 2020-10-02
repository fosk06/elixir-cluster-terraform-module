variable "gcp_project_id" {
  description = "gcp project id"
}

variable "gcp_region" {
  description = "Where the cluster will live"
}

variable "gcp_default_zone" {
  description = "GCP default zone"
}


# ---------------------------------------------------------------------------------------------------------------------
# VM variables
# ---------------------------------------------------------------------------------------------------------------------

variable "image" {
  default     = "debian-cloud/debian-10"
  description = "kind of the image for the vm"
}

variable "machine_type" {
  type        = string
  description = "Machine type to use for APIs"
  default = "n1-standard-1"
}

variable "disk_type" {
  type        = string
  description = "size of the disk"
  default = "pd-ssd"
}

variable "disk_size" {
  type        = number
  description = "size of the disk"
  default = 50
}

variable "vm_preemptible" {
  type        = bool
  description = "are vm preamtible"
  default = false
}

variable session_affinity {
  type        = string
  description = "session affinity for target pool"
  default = "CLIENT_IP"
}

# ---------------------------------------------------------------------------------------------------------------------
# Elixir application variables
# ---------------------------------------------------------------------------------------------------------------------


variable "release_url" {
  type        = string
  description = "release of the URL"
  default = "n1-standard-1"
}

variable "secret_key_base" {
  type        = string
  description = "secret key to deploy and run elixir application"
}

variable startup_script_url {}
variable shutdown_script_url {}
variable service_name {}
variable service_namespace {}
variable cluster_hostname {}
variable tags {}
variable vpc_name {}
variable service_account_email {}