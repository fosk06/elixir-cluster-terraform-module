variable "namespace_name" {
  type        = string
  description = "name of the service directory namespace"
  default = "mycompany"
}

variable "service_name" {
  type        = string
  description = "name of the service  directory service"
  default = "api"
}

variable "dns_managed_zone_name" {
  type        = string
  description = "name of the dns managed zone"
  default = "elixir-application-app"
}

variable "dns_managed_zone_dns_name" {
  type        = string
  description = "dns hostname record like myapp.com. "
  default = "mycompany.app."
}