variable "nginx_ports" {
  type = number
  description = "nginx port"
  default = 80
}

variable "name" {
  type = string
  description = "deployment-name"
  default = "nginx-webserver"
}

variable "namespace" {
  type = string
  description = "Kubernetes namespace where nginx is deployed"
  default = "webserver-ns"
}

variable "metadata_name" {
  type = string
  description = "Deployment metadata name"
  default = "nginx"
}

variable "image_name" {
  type = string
  description = "Docker image name"
  default = "nginx"
}

variable "container_name" {
  type = string
  description = "Name to be assigned to the container"
  default = "nginx"
}
