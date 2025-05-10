provider "aws" {
  region = "ap-south-1"

}

module "vpc" {
  source                    = "./modules/vpc"
  vpc_name                  = "my-vpc"
  vpc_cidr_block            = "10.0.0.0/16"
  subnet_name               = "my-subnet"
  subnet_cidr_block         = "10.0.0.0/24"
  subnet_availabilityzone   = "ap-south-1a"
  aws_internet_gateway_name = "my-ig"
  aws_routetable_name       = "my-route-table"
  aws_rotetable_cidr_block  = "0.0.0.0/0"

}

module "security" {
  source              = "./modules/security"
  security_group_name = "my-security"
  vpc_id              = module.vpc.vpc_id
  ingress_cidr_block  = "0.0.0.0/0"
  egress_cidr_block   = "0.0.0.0/0"


}

module "ec2" {
  source            = "./modules/ec2"
  ami_id            = "ami-0e35ddab05955cf57"
  instance_type     = "t2.micro"
  subnet_id         = module.vpc.subnet_id
  instance_name     = "my-insstance"
  security_group_id = module.security.security_group_id_output

}
