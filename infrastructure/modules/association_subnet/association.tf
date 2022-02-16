resource "aws_route_table_association" "association_pub1_sub" {
  subnet_id      = "${var.public1_subnet_id}"
  route_table_id = var.pub_route_table_id
}

resource "aws_route_table_association" "association_private1_sub" {
  subnet_id      = "${var.private1_subnet_id}"
  route_table_id = var.private_route_table_id
}

resource "aws_route_table_association" "association_private2_sub" {
  subnet_id      = "${var.private2_subnet_id}"
  route_table_id = var.private_route_table_id
}