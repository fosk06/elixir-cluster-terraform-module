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