variable "customer" {
    type = string
    default = "iti"
}
variable "env_name" {
    type = string
    default = "dev"
}
variable "cidr_block_private_sub1" {
    type = string
    default = "10.0.1.0/24"
}

variable "cidr_block_private_sub2" {
    type = string
    default = "10.0.2.0/24"
}

variable "cidr_block_public_sub1" {
    type = string
    default = "10.0.3.0/24"
}

variable "new_vpc_id" {
    
}