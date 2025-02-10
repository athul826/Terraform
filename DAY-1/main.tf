provider "aws" {
    region = "us-east-1"
  
}
# create vpc
resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"

    tags = {
        Name = "my-vpc"
    } 
}

# create internet gateway and attach it with vpc
resource "aws_internet_gateway" "vpc-ig" {
    vpc_id = aws_vpc.my_vpc.id

    tags = {
        Name = "my-ig"
    }
  
}