resource "aws_vpc" "main" {
  cidr_block = "${var.cidr_block_vpc}"
 
  tags = {
    Name = "${var.customer}_${var.env_name}_vpc"
  }
}