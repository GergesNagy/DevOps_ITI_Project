output "new_vpc_id" {
    value = aws_vpc.main.id
}

output "vpc_cider" {
    value = aws_vpc.main.cidr_block
}