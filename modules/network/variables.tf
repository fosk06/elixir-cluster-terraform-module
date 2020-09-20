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
  default = "10.2.0.0/16"
}

