resource "aws_subnet" "public_subnet" {
  vpc_id            = "${aws_vpc.my_vpc.id}"
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"

  tags {
    Name = "Public Subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = "${aws_vpc.my_vpc.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags {
    Name = "Nat-ed subnet"
  }
}