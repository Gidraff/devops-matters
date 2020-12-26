resource "aws_instance" "jenkins_instance" {
  ami                         = var.instance_ami
  instance_type               = "t2.micro"
  key_name                    = "jenkins_key"
  vpc_security_group_ids      = ["${aws_security_group.allow_ssh.id}"]
  subnet_id                   = "${aws_subnet.public_subnet.id}"
  associate_public_ip_address = true

  tags = {
    Name = "JenkinsCI"
  }
}
