variable "aws_region" {
  type        = string
  description = "Region"
}
variable "aws_access_key" {
  type        = string
  description = "AWS access key"
}
variable "aws_secret_key" {
  type        = string
  description = "AWS secret key"
}
variable "instance_ami" {
  type        = string
  description = "Instance AMI"
}

###########################
##  General Variables   ##
###########################
variable "region" {
  type    = string
  default = "us-east-2"
}


variable "vpc_cidr" {
}

# # ec2
# variable "ami" {
# }
# variable "ec2_instance_type" {
# }
# variable "key_name" {
# }
# variable "ec2_ingress_cidr" {
# }

# variable "name" {
# }

