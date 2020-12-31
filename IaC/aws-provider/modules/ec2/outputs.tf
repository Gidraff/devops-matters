output "ec2_ip" {
  value = aws_instance.default.public_ip
}