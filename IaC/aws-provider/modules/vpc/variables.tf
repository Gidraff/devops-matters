variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  type        = string
  description = "Specify a valid IP range for VPC CIDR"
}

variable "vpc_enable_dns_support" {
  default     = true
  type        = bool
  description = "Specify whether VPC dns support required"
}

variable "vpc_enable_dns_hostnames" {
  default     = true
  type        = bool
  description = "Specify whether VPC dns hostname required"
}

variable "tags" {
  type        = map(string)
  description = "Specify list of tags to be associated to each resource"
}

variable "region" {
  default     = "us-east-2"
  type        = string
  description = "Specify a valid IP range for VPC CIDR"
}