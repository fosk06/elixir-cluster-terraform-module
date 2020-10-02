# ---------------------------------------------------------------------------------------------------------------------
# GLOBAL GCP VARIABLES 
# ---------------------------------------------------------------------------------------------------------------------

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
# NETWORK VARIABLES
# ---------------------------------------------------------------------------------------------------------------------

variable "vpc_name" {
  type        = string
  description = "name of the vpc"
}

variable "subnet_name" {
  type        = string
  description = "name of the subnet"
}

variable "subnet_cidr_range" {
  type        = string
  description = "ip range of subnetwork"
}

variable "namespace_name" {
  type        = string
  description = "name of the service directory namespace"
}

variable "service_name" {
  type        = string
  description = "name of the service  directory service"
}

variable "dns_managed_zone_name" {
  type        = string
  description = "name of the dns managed zone"
}

variable "dns_managed_zone_dns_name" {
  type        = string
  description = "dns hostname record like myapp.com. "
}


# ---------------------------------------------------------------------------------------------------------------------
# STORAGE VARIABLES
# ---------------------------------------------------------------------------------------------------------------------

variable "gcp_bucket_name" {
  type        = string
  description = "name of the gcp bucket"
}

# ---------------------------------------------------------------------------------------------------------------------
# VIRTUAL MACHINES VARIABLES
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

variable "release_url" {
  type        = string
  description = "release of the URL"
}

variable "elixir_secret_key_base" {
  type        = string
  description = "secret key to deploy and run elixir application"
}