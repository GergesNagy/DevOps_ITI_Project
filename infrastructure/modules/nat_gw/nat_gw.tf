resource "aws_eip" "elip" {
  vpc      = true
  
  tags = {
    Name = "${var.customer}_${var.env_name}_EIP"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.elip.id
  subnet_id     = var.public1_subnet_id

  tags = {
    Name = "${var.customer}_${var.env_name}_nat_gw"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [var.gw_id]
}