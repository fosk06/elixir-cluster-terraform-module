/*
  Project wide variables
*/

################ Global configuration #################################################

variable "gcp_project_id" {
  description = "gcp project id"
}

variable "gcp_region" {
  description = "Where the cluster will live"
}

variable "gcp_default_zone" {
  description = "GCP default zone"
}



################ Network #################################################

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

################ Service directory #################################################

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

################ Storage #################################################

variable "gcp_bucket_name" {
  type        = string
  description = "name of the service directory namespace"
}



################ Virtual machines ########################################

variable "image" {
  default     = "debian-cloud/debian-10"
  description = "kind of the image for the vm"
}

variable "machine" {
  type        = string
  description = "Machine type to use for APIs"
  default = "n1-standard-1"
}