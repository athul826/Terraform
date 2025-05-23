provider "aws" {
  region = "us-east-1"

}

module "vpc" {
  source                   = "./modules/vpc"
  vpc_name                 = "demo-vpc"
  vpc_cidr                 = "10.0.0.0/16"
  internet_gateway_name    = "my-ig"
  subnet_name              = "my-subnet"
  subnet_availability_zone = "us-east-1a"
  subnet_cidr              = "10.0.0.0/24"
  route_table_name         = "my-route-table"
  routetable_cidr          = "0.0.0.0/0"

}

module "security" {
  source              = "./modules/security"
  security_group_name = "my-security"
  ingress_cidr_block  = "0.0.0.0/0"
  egress_cidr_block   = "0.0.0.0/0"
  vpc_id              = module.vpc.vpc_id

}

module "ec2" {
  source                 = "./modules/ec2"
  ami                    = ""
  instance_type          = "t2.micro"
  instance_name          = "my-instance"
  subnet_id              = module.vpc.subnet_id
  vpc_security_group_ids = module.security.security_group_id

}


