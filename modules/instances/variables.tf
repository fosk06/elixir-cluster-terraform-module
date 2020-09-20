variable "gcp_project_id" {
  description = "gcp project id"
}

variable "gcp_region" {
  description = "Where the cluster will live"
}

variable "gcp_default_zone" {
  description = "GCP default zone"
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