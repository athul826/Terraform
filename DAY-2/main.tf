provider "aws" {
    region = var.instance-name
  
}

# create vpc in us-east-1
resource "aws_vpc" "demo" {
    cidr_block = var.vpc_cidrblock
  
}




resource "aws_instance" "demo" {
    ami = var.aws-ami
    instance_type = var.aws-instance-type

    tags = {
        Name = var.instance-name
    }
  
}