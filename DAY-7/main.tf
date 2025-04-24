provider "aws" {
  region = "us-east-1"

}

variable "vpc-cidr_block" {
  type    = string
  default = "10.0.0.0/16"

}
variable "vpc_name" {
  type    = string
  default = "demo-vpc"

}

variable "internet-gateway-name" {
  type    = string
  default = "demo-ig"

}
variable "subnet-cidr_block" {
  type    = string
  default = "10.0.0.0/24"

}
variable "availability_zone" {
  type    = string
  default = "us-east-1a"

}

variable "subnet-name" {
  type    = string
  default = "demo-subnet"

}

variable "route-table-name" {
  default = "public-route"

}
variable "route-table-cidr_block" {
  default = "0.0.0.0/0"

}

variable "security-group-name" {
  default = "my-security"

}
variable "securiy_cidr_block" {
  default = "0.0.0.0/0"

}
variable "aws-ami" {
  default = "isdf64665"

}

variable "aws_instance_type" {
  default = "t2.micro"

}
variable "instance-name" {
  default = "demo-instance"

}



# create vpc for instance 
resource "aws_vpc" "demo" {
  cidr_block = var.vpc-cidr_block

  tags = {
    Name = var.vpc_name
  }

}

# create internet gateway for instance 
resource "aws_internet_gateway" "demo" {
  vpc_id = aws_vpc.demo.id
  tags = {
    Name = var.internet-gateway-name
  }

}

# create subnet for instance 
resource "aws_subnet" "demo" {
  vpc_id                  = aws_vpc.demo.id
  cidr_block              = var.subnet-cidr_block
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet-name
  }
}

# creare route table for instance 
resource "aws_route_table" "demo" {
  vpc_id = aws_vpc.demo.id

  route {
    gateway_id = aws_internet_gateway.demo.id
    cidr_block = var.route-table-cidr_block
  }

  tags = {
    Name = var.route-table-name
  }

}
# create route table association for subnets 
resource "aws_route_table_association" "demo" {
  subnet_id      = aws_subnet.demo.id
  route_table_id = aws_route_table.demo.id

}

# create security group for instance 
resource "aws_security_group" "demo" {
  vpc_id = aws_vpc.demo.id
  name   = var.security-group-name

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.securiy_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.securiy_cidr_block]
  }

}

# create instance 
resource "aws_instance" "demo" {
  ami                         = var.aws-ami
  instance_type               = var.aws_instance_type
  subnet_id                   = aws_subnet.demo.id
  vpc_security_group_ids      = [aws_security_group.demo.id]
  associate_public_ip_address = true

  tags = {
    Name = var.instance-name
  }


}
