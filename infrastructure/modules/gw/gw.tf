resource "aws_internet_gateway" "gw" {
  vpc_id = var.new_vpc_id
  
  tags = {
    Name = "${var.customer}_${var.env_name}_gw"
  }
}