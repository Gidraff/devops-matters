output "vpc_id" {
  value = aws_vpc.default.id
}

output "vpc_cidr_block" {
  value = aws_vpc.default.cidr_block
}

output "public_subnets" {
  value = aws_subnet.public.*.id
}

output "private_subnets" {
  value = aws_subnet.private.*.id
}

output "public_route_table" {
  value = aws_route_table.public_rt.id
}

output "private_route_table" {
  value = aws_route_table.private_rt.id
}
