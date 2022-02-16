resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "pub_key" {
  key_name = "${var.customer}_${var.env_name}_Ops"
  public_key = tls_private_key.key.public_key_openssh
  provisioner "local-exec" { # Create "myKey.pem" to your computer!!
  command = "echo '${tls_private_key.key.private_key_pem}' > ./${var.customer}_${var.env_name}_Ops.pem"
  }
}