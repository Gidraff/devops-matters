resource "aws_eip" "nat_gw_eip" {
  vpc = true
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = "${aws_eip.nat_gw_eip.id}"
  subnet_id = "${aws_subnet.public_subnet.id}"
}
