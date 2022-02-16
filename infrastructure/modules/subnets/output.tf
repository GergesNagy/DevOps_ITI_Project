output "private1_subnet_id" {
    value = aws_subnet.private1.id
}

output "private2_subnet_id" {
    value = aws_subnet.private2.id
}

output "public1_subnet_id" {
    value = aws_subnet.public1.id
}

output "private1_subnet_cidr" {
    value = aws_subnet.private1.cidr_block
}

output "private2_subnet_cidr" {
    value = aws_subnet.private2.cidr_block
}

output "public1_subnet_cidr" {
    value = aws_subnet.public1.cidr_block
}