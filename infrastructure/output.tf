output "public_ec2_public_ip" {
    value = module.ec2_module.public_ec2_public_ip
}

output "pub_key" {
    value = "${module.key_pair.key_name}.pem"
}

output "endpoint" {
    value = module.eks_module.endpoint
}