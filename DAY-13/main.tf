provider "aws" {
    region = "us-east-1"
  
} 

module "vpc" { 
    source = "./modules/vpc"
    vpc_cidr = "10.0.0.0/16"
    vpc_name = "my-vpc"
    subnet_name = "my-subnet"
    subnet_availabilityzone = "us-east-1a"
    subnet_cidrblock = "10.0.0.0/24"
    internet_gateway_name = "my-ig"
    route_table_name = "my-route-table"
    route_table_cidrblock = "0.0.0.0/0"
  
} 

module "secruity_group" {
    source = "./modules/security"
    security_group_name = "my-security"
    secruriy_group_vpc_id = module.vpc.vpc_output_id 
    security_group_ingress_cidr_block = "0.0.0.0/0"
    secruriy_group_egress_cidr_block = "0.0.0.0/0"
  
} 

module "ec2_instance" {
    source = "./modules/ec2"
    ami = "ami-084568db4383264d4"
    instance_type = "t2.micro"
    instance_subnet_id = module.vpc.subnet_ouput_id
    instance_security_group_id = module.secruity_group.security_group_id_output
    instance_name = "my-instance-2"
  
}