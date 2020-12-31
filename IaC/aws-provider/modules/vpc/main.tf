# VPC Module to create VPC, Public subnets, Private subnets, Internet Gateway, EIP and NAT gateway
locals {
  subnets = {
    "${var.region}a" = "172.16.0.0/21"
    "${var.region}b" = "172.16.8.0/21"
    "${var.region}c" = "172.16.16.0/21"
  }
}

# VPC
resource "aws_vpc" "default" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = var.vpc_enable_dns_support
  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  tags = merge(
    var.tags,
    {
      "Name" = "${terraform.workspace}-VPC"
    },
  )
  lifecycle {
    ignore_changes = [tags]
  }
}

# 3 Public Subnets spread across all availability zones
resource "aws_subnet" "public" {
  count      = length(data.aws_availability_zones.available.names)
  vpc_id     = aws_vpc.default.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index + 0)
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = true
  tags = merge(
    var.tags,
    {
      Name = "PublicSubnet-${count.index + 1}"
    },
  )
}

# 3 Private subnets spread across all availability zones
resource "aws_subnet" "private" {
  count      = length(data.aws_availability_zones.available.names)
  vpc_id     = aws_vpc.default.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index + 10)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  tags = merge(
    var.tags,
    {
      Name = "PrivateSubnet-${count.index + 1}"
    }
  )
}

# Internet gateway
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
  tags = merge(
    var.tags,
    {
      Name = "${terraform.workspace}-InternetGateway"
    }
  )
}

# Public route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.default.id
  tags = merge(
    var.tags,
    {
      Name = "PublicRT-${terraform.workspace}"
    }
  )
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.default.id
  timeouts {
    create = "5m"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public.*.id)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public_rt.id
}

# Private route table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.default.id
  tags = merge(
    var.tags,
    {
      Name = "PrivateRT-${terraform.workspace}"
    }
  )
}

resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.default.id
  timeouts {
    create = "5m"
  }
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private.*.id)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private_rt.id
}

# Elastic IP address
resource "aws_eip" "default" {
  vpc = true
}

# NAT gateway
resource "aws_nat_gateway" "default" {
  allocation_id = aws_eip.default.id
  subnet_id     = element(aws_subnet.public.*.id, 0)
  tags = merge(
    var.tags,
    {
      Name = "NAT-${terraform.workspace}"
    }
  )
  depends_on = [aws_internet_gateway.default]
}

# RDS DB subnet group
resource "aws_db_subnet_group" "database" {
  name        = "rds-db-subnet-group-${terraform.workspace}"
  description = "Database subnet group for rds-db-subnet-group-${terraform.workspace}"
  subnet_ids  = aws_subnet.private.*.id
  tags = merge(
    var.tags,
    {
      Name = "rds-db-subnet-group-${terraform.workspace}"
    }
  )
}