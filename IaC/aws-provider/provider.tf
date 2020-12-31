provider "aws" {
  region = "us-east-2"
}

terraform {
  backend "s3" {
    bucket = "jenkins-ci-server"
    key    = "terraform.tfstate"
    region = "us-east-2"
  }
}