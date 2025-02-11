provider "aws" {
  region = var.aws-region

}

# create vpc in us-east-1
resource "aws_vpc" "demo" {
  cidr_block       = var.vpc_cidrblock
  instance_tenancy = "default"
  tags = {
    Name = "my_vpc"
  }
}

# create internet gateway for vpc
resource "aws_internet_gateway" "demo-ig" {
  vpc_id = aws_vpc.demo.id

}
# create public subnet
resource "aws_subnet" "demo" {
  vpc_id                  = aws_vpc.demo.id
  cidr_block              = var.subnet-cidr_block-1a
  availability_zone       = var.availability_zone-1A
  map_public_ip_on_launch = var.map_public_ip_on_launch
}
# create route table 
resource "aws_route_table" "demo" {
  vpc_id = aws_vpc.demo.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo-ig.id
  }
}
# associate route table with subnet
resource "aws_route_table_association" "name" {
  subnet_id      = aws_subnet.demo.id
  route_table_id = aws_route_table.demo.id

}
# create security group
resource "aws_security_group" "demo" {
  vpc_id = aws_vpc.demo.id
  name   = "my-security"

  ingress {
    description = "allow traffic from ssh port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh-cidr_block]
  }
  ingress {
    description = "allow traffic from http port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.http-cidr-block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# create public subnets in public 1a
resource "aws_instance" "demo" {
  instance_type               = var.aws-instance-type
  ami                         = var.aws-ami
  subnet_id                   = aws_subnet.demo.id
  vpc_security_group_ids      = [aws_security_group.demo.id]
  associate_public_ip_address = true

  tags = {
    Name = var.instance-name
  }
}
