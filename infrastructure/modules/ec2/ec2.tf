resource "aws_instance" "public_ec2" {
  ami           = "ami-0231217be14a6f3ba"
  instance_type = var.ec2_instance_type
  subnet_id = var.public1_subnet_id
  vpc_security_group_ids = [var.sg_id]
  associate_public_ip_address = true
  key_name = var.key_name

  tags = {
    Name = "${var.customer}_${var.env_name}_public"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = "${file("${var.customer}_${var.env_name}_Ops.pem")}"
    host        = "${self.public_ip}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm",
      "sudo yum install epel-release-latest-7.noarch.rpm -y",
      "sudo yum update -y",
      "sudo yum install git python python-devel python-pip openssl ansible -y"
    ]
  }

  provisioner "file" {
    source      = "./iti_dev_Ops.pem"
    destination = "/home/ec2-user/iti_dev_Ops.pem"
  }
}