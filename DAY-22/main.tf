provider "aws" {
    region = "us-east-1"

}

module "vpc" {
    source = "./modules/vpc"
    vpc-name = "my-vpc"
    vpc-cidr-block = "10.0.0.0/16"
    ig-name = "my-ig"
    subnet-name = "my-subnet"
    subnent_availabilityzone = "us-east-1a"
    subnet_cidr_block = "10.0.1.0/24"
    aws-route_table_name = "my-route-table"
    aws-route_table_cidr = "0.0.0.0/0"
}

module "security" {
    source = "./modules/security"
    aws_security_group_name = "my-security"
    vpc_id = module.vpc.vpc_id
    ingress-cidr = "0.0.0.0/0"
    egress_cidr = "0.0.0.0/0"

}

module "ec2" {
    source = "./modules/ec2"
    ami = "ami-02457590d33d576c3"
    instance_name = "my-instance"
    instance_type = "t2.micro"
    subnet_id = module.vpc.subnet_id
    security_groups = module.security.security_group_id

}