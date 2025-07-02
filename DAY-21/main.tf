provider "aws" {
  region = "us-east-1"

}

module "vpc" {
  source                   = "./modules/vpc"
  vpc_name                 = "my-vpc"
  vpc_cidr_block           = "10.0.0.0/16"
  ig_name                  = "my-ig"
  subnet_name              = "my-subnet"
  subnent_availabilityzone = "us-east-1a"
  subnet_cidr_block        = "10.0.0.0/24"
  route_table_name         = "my-route-table"
  route_table_cidr         = "0.0.0.0/0"


}

module "security" {
  source              = "./modules/security"
  security_group_name = "my-security"
  vpc_id              = module.vpc.vpc_id
  egress_cidr         = "0.0.0.0/0"
  inggress_cidr       = "0.0.0.0/0"

}

module "ec2" {
  source                 = "./modules/ec2"
  ami                    = "ami-02457590d33d576c3"
  instance_type          = "t2.micro"
  instance_name          = "demo"
  subnet_id              = module.vpc.subnet_id
  vpc_security_group_ids = module.security.security_group_id

}
