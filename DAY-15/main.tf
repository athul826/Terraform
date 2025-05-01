provider "aws" {
  region = "ap-south-1"

}

module "vpc" {
  source                  = "./modules/vpc"
  vpc_name                = "demo-vpc"
  vpc_cidr_block          = "10.0.0.0/16"
  subnet_name             = "my-subnet"
  subnet_cidrblock        = "10.0.0.0/24"
  subnet_availabilityzone = "ap-south-1a"
  internet_gateway_name   = "my-ig"
  route_table_cidrblock   = "0.0.0.0/0"
  route_table_name        = "my-rote-table"

}

# create module for security group 
module "secruity_group" {
  source                = "./modules/security"
  secruity_group_name   = "my-security"
  vpc_id                = module.vpc.vpc_id
  secruity_ingress_cidr = "0.0.0.0/0"
  secruity_egress_cidr  = "0.0.0.0/0"
}

# create ec2 instance 
module "ec2" {
  source            = "./modules/ec2"
  instance_ami      = "ami-0e35ddab05955cf57"
  instance_type     = "t2.micro"
  subnet_id         = module.vpc.subnet_id
  security_group_id = module.secruity_group.secruity_id
  instance_name     = "athul-instance"



}
