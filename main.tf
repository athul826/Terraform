# create modules and call all files which we created inside modules in this root main.tf files
provider "aws" {
  region = "us-east-1"
}
module "vpc" {
  source         = "./modules/vpc"
  vpc-cidr_block = "10.0.0.0/16"
  vpc-name       = "my-demo-vpc"

}

# call module for subnet
module "subnet" {
  source                  = "./modules/subnet"
  vpc_id                  = module.vpc.vpcid
  subnet-cidr             = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  subnet-name             = "my-subnet"
}

# call module for secruity group
module "security_groups" {
  source = "./modules/security_group"
  name   = "my-security"
  vpc_id = module.vpc.vpcid
}

# call ec2 module for instance
module "ec2" {
  source          = "./modules/ec2"
  ami             = "ami-05b10e08d247fb927"
  instance_type   = "t2.micro"
  instance-name   = "my-instance"
  subnet_id       = module.subnet.subnet_id
  security_groups = module.security_groups.aws_security_group_id
}



