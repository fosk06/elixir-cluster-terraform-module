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

variable "node_distribution_port" {
  type        = string
  description = "erlang node distribution port"
  default = "9999"
}


# ---------------------------------------------------------------------------------------------------------------------
# STORAGE VARIABLES
# ---------------------------------------------------------------------------------------------------------------------

variable "gcp_bucket_name" {
  type        = string
  description = "name of the gcp bucket"
}