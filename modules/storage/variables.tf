variable "gcp_project_id" {
  description = "gcp project id"
}

variable "gcp_region" {
  description = "Where the cluster will live"
}

variable "gcp_default_zone" {
  description = "GCP default zone"
}

variable "gcp_bucket_name" {
  type        = string
  description = "name of the gcp bucket"
}
