module "vpc_module" {
    source = "./modules/vpc"
    customer = var.customer
    env_name = var.env_name
    cidr_block_vpc = var.cidr_block_vpc
}

module "gw_module" {
    source = "./modules/gw"
    customer = var.customer
    env_name = var.env_name
    new_vpc_id = module.vpc_module.new_vpc_id
}

module "nat_gw_module" {
    source = "./modules/nat_gw"
    customer = var.customer
    env_name = var.env_name
    public1_subnet_id = module.subnet_module.public1_subnet_id
    gw_id = module.gw_module.gw_id
}

module "route_table_module" {
    source = "./modules/route_table"
    customer = var.customer
    env_name = var.env_name
    new_vpc_id = module.vpc_module.new_vpc_id
    gw_id = module.gw_module.gw_id
    nat_gw_id = module.nat_gw_module.nat_gw_id
}

module "subnet_module" {
    source = "./modules/subnets"
    customer = var.customer
    env_name = var.env_name
    cidr_block_private_sub1 = var.cidr_block_private_sub1
    cidr_block_private_sub2 = var.cidr_block_private_sub2
    cidr_block_public_sub1 = var.cidr_block_public_sub1
    cidr_block_public_sub2 = var.cidr_block_public_sub2
    new_vpc_id = module.vpc_module.new_vpc_id
}

module "subnet_association_module" {
    source = "./modules/association_subnet"
    public1_subnet_id = module.subnet_module.public1_subnet_id
    public2_subnet_id = module.subnet_module.public2_subnet_id
    private1_subnet_id = module.subnet_module.private1_subnet_id
    private2_subnet_id = module.subnet_module.private2_subnet_id
    pub_route_table_id = module.route_table_module.pub_route_table_id
    private_route_table_id = module.route_table_module.private_route_table_id
}

module "key_pair" {
    source = "./modules/key_pair"
    customer = var.customer
    env_name = var.env_name
}

module "ec2_module" {
    source = "./modules/ec2"
    customer = var.customer
    env_name = var.env_name
    ec2_instance_type = var.ec2_instance_type
    public1_subnet_id = module.subnet_module.public1_subnet_id
    sg_id = module.security_group_module.sg_id
    key_name = module.key_pair.key_name
    endpoint = module.eks_module.endpoint
    depends_on = [
      module.eks_module
    ]
}

module "security_group_module" {
    source = "./modules/security_groups"
    customer = var.customer
    env_name = var.env_name
    new_vpc_id = module.vpc_module.new_vpc_id
}

module "eks_module" {
    source = "./modules/eks"
    new_vpc_id = module.vpc_module.new_vpc_id
    public1_subnet_cidr = module.subnet_module.public1_subnet_cidr
    private1_subnet_id = module.subnet_module.private1_subnet_id
    private2_subnet_id = module.subnet_module.private2_subnet_id
    key_name = module.key_pair.key_name
    public2_subnet_id = module.subnet_module.public2_subnet_id
    public1_subnet_id = module.subnet_module.public1_subnet_id
}

####################################################

resource "null_resource" "ansible" {
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = "${file("${var.customer}_${var.env_name}_Ops.pem")}"
    host        = module.ec2_module.public_ec2_public_ip
  }

  
  provisioner "remote-exec" {
      inline = [
        "mkdir -p ansible/plays/",
        "mkdir -p ansible/roles/jenkins/tasks/",
        "sudo mv jenkins_deploy.yml /home/ec2-user/ansible/plays/",
        "sudo mv main.yml /home/ec2-user/ansible/roles/jenkins/tasks/",
        "ansible-playbook /home/ec2-user/ansible/plays/jenkins_deploy.yml"
      ]
  }
  depends_on = [
      module.ec2_module
  ]
}