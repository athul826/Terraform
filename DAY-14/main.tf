provider "aws" {
  region = "us-east-1"

}

module "vpc" {
  source                  = "./modules/vpc"
  vpc_name                = "demo-vpc"
  vpc_cid                 = "10.0.0.0/16"
  subnet_name             = "my-demo-subnet"
  subnet_availabilityzone = "us-east-1a"
  subnet_cidrblock        = "10.0.0.0/24"
  internet_gateway_name   = "demo-ig"
  route_table_name        = "my-route-table"
  route_table_cidrblock   = "0.0.0.0/0"

}
# call the security group modules 
module "security_group" {
  source                            = "./modules/secruity"
  secruity_group_name               = "my-security"
  secruity_group_vpc_id             = module.vpc.vpc_id_output
  security_group_ingress_cidr_block = "0.0.0.0/0"
  secruity_group_egress_cidr_block  = "0.0.0.0/0"
}
# create the ec2 instance 
module "ec2" {
  source                = "./modules/ec2"
  instance_name1        = "demo-instance2"
  instance_ami1         = "ami-0e449927258d45bc4"
  instance_type1        = "t2.micro"
  instance_subnet_id1   = module.vpc.subnet_id_output
  instance_security_id1 = module.security_group.security_group_id_output

}

