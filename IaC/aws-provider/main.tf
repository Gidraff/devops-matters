module "network" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  tags     = {
    Name = "vpc"
  }
}
module "instance" {
  source                      = "./modules/ec2"
  name                        = "jenkins-ec2"
  ami                         = var.ami
  instance_type               = var.ec2_instance_type
  key_name                    = var.key_name
  vpc_id                      = module.network.vpc_id
  subnet_id                   = module.network.public_subnets[0]
  ec2_ingress_cidr            = var.ec2_ingress_cidr
  associate_public_ip_address = true
  tags     = {
    Name = "vpc"
  }
}