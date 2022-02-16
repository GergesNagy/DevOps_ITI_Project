resource "aws_subnet" "private1" {
  vpc_id     = var.new_vpc_id
  cidr_block = "${var.cidr_block_private_sub1}"
  availability_zone = "us-east-2a"

  tags = {
    Name = "${var.customer}_${var.env_name}_private_subnet1"
  }
}

resource "aws_subnet" "private2" {
  vpc_id     = var.new_vpc_id
  cidr_block = "${var.cidr_block_private_sub2}"
  availability_zone = "us-east-2b"

  tags = {
    Name = "${var.customer}_${var.env_name}_private_subnet2"
  }
}

resource "aws_subnet" "public1" {
  vpc_id     = var.new_vpc_id
  cidr_block = "${var.cidr_block_public_sub1}"
  availability_zone = "us-east-2c"

  tags = {
    Name = "${var.customer}_${var.env_name}_public_subnet1"
  }
}
