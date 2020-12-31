resource "aws_instance" "default" {
  ami                    = var.ami
  instance_type          = var.instance_type
  user_data              = var.user_data
  user_data_base64       = var.user_data_base64
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.default.id]
  iam_instance_profile   = var.iam_instance_profile
  associate_public_ip_address = var.associate_public_ip_address
}

resource "aws_security_group" "default" {
  name        = "${var.name}-sg"
  description = "only ssh inbound"
  vpc_id      = var.vpc_id
 
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = var.ec2_ingress_cidr
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "TCP"
    cidr_blocks = var.ec2_ingress_cidr
  }
 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.name}-sg"
  }
}