provider "aws" {
    region = "us-east-1"

}

module "vpc" {
    source = "./modules/vpc"
    vpc-name = "my-vpc"
    vpc-cidr = "10.0.0.0/16"
    internet_gateway_name = "my-ig"
    subnet-name = "my-subnet"
    subnet-cidr = "10.0.0.0/24"
    subnet-availability_zone = "us-east-1a"
    route_table_name = "my-route-table"
    route_table_cidr = "0.0.0.0/0"

}

module "secuirty" {
    source = "./modules/security"
    vpc-id = module.vpc.vpc-id
    secuirty-group-name = "my-security"
    ingress-cidr = "0.0.0.0/0"
    egress-cidr = "0.0.0.0/0"

}

module "ec2" {
    source = "./modules/ec2"
    ami = "ami-02457590d33d576c3"
    instance_type = "t2.micro"
    subnet_id = module.vpc.subnet-id
    aws_security_group = module.secuirty.secuirty-group-id
    instance_name = "my-instance"

}