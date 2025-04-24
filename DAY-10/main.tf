provider "aws" {
  region = "us-east-1"

}

module "vpc" {
  source                  = "./modules/vpc"
  vpc_cidr                = "10.0.0.0/16"
  vpc_name                = "my-demo-vpc"
  subnet_cidrblock        = "10.0.0.0/24"
  subnet_availabilityzone = "us-east-1a"
  subnet_name             = "demo-subnet"
  ineternet_gateway_name  = "my-ig"
  route_table_cidrblock   = "0.0.0.0/0"
  route_table_name        = "my-route-table"

}

module "securiy-group" {
  source              = "./modules/security_group"
  vpc_id_1            = module.vpc.vpc_id
  security_group_name = "my-securiy"
  ingress_cidr        = ["0.0.0.0/0"]
  egress_cidr         = ["0.0.0.0/0"]
}

module "ec2" {
  source                     = "./modules/ec2"
  instance_ami               = "ami-084568db4383264d4"
  instance_type              = "t2.micro"
  instance_subnet_id         = module.vpc.subnet_id
  instance_security_group_id = module.securiy-group.secruriy_group_id
  instance_name              = "my-instance"
}
