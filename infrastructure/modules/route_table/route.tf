resource "aws_route_table" "public_rt" {
  vpc_id = var.new_vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gw_id
  }

  tags = {
    Name = "${var.customer}_${var.env_name}_public_route_table"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = var.new_vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.nat_gw_id
  }

  tags = {
    Name = "${var.customer}_${var.env_name}_private_route_table"
  }
}