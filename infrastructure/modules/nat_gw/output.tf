output "nat_gw_id" {
    value = aws_nat_gateway.nat_gw.id
}

output "pub_nat_gw" {
    value = aws_nat_gateway.nat_gw.public_ip
}