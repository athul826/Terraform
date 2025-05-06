provider "aws" {
    region = "ap-south-1"
  
} 

module "vpc" {
    source = "./modules/vpc"
    vpc_name = "my-vpc"
    vpc_cidr_block = "10.0.0.0/16"
    subnet_name = "my-subnet"
    subnet_availabiltyzone = "ap-south-1a"
    subnet_cidr_block = "10.0.0.0/24"
    aws_internet_gateway_name = "my-ig"
    route_table_name = "my-route-table"
    route_table_cidr_block = "0.0.0.0/0"
  
}

module "security" {
    source = "./modules/security"
    secruity_group_name = "my-security"
    security_ingress_cidr = "0.0.0.0/0"
    secruity_egress_cidr = "0.0.0.0/0"
    vpc_id = module.vpc.vpc_id
  
}

module "ec2" {
   source = "./modules/ec2"
   instance_ami = ""
   instance_name = "my-instance"
   instance_type = "t2.micro"
   vpc_security_group_id = module.security.security_group_id
   subnet_id = module.vpc.subnet_id
  
}