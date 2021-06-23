provider "aws" {
  region     = "us-east-2"
  access_key = "var.AWS_ACCESS_KEY"
  secret_key = "var.AWS_SECRET_KEY"
}

terraform {
  backend "s3" {
    bucket = "eks-infras"
    key    = "terraform.tfstate"
    region = "us-east-2"
  }
}
