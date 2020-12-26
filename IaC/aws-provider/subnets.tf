resource "aws_subnet" "public_subnet" {
  vpc_id            = "${aws_vpc.my_vpc.id}"
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-2a"

  tags = {
    Name = "PubSub"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = "${aws_vpc.my_vpc.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-2a"

  tags = {
    Name = "Nat-ed-sub"
  }
}