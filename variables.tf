/*
  Project wide variables
*/

variable "region" {
  default     = "europe-west1"
  description = "Where the cluster will live"
}

# https://cloud.google.com/filestore/docs/regions
variable "default_zone" {
  default     = "europe-west1-c"
  description = "Belgium zone will be the default zone"
}

variable "image" {
  default     = "debian-cloud/debian-10"
  description = "kind of the image for the vm"
}

variable "machine" {
  type        = string
  description = "Machine type to use for APIs"
  default = "n1-standard-1"
}

variable "subnet_name" {
  type        = string
  description = "name of the subnet"
  default = "ex-vpc"
}

variable "subnet_cidr_range" {
  type        = string
  description = "ip range of subnetwork"
  default = "10.2.0.0/16"
}

