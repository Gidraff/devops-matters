resource "aws_instance" "jenkins_instance" {
  ami                         = "ami-0ac019f4fcb7cb7e6"
  instance_type               = "t2.micro"
  key_name                    = "Lenovo T410"
  vpc_security_group_ids      = ["${aws_security_group.allow_ssh.id}"]
  subnet_id                   = "${aws_subnet.public_subnet.id}"
  associate_public_ip_address = true

  tags {
    Name = "My Instance"
  }
}
