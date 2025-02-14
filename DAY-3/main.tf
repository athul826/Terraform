provider "aws" {
  region = "us-east-1"

}
# create aws vpc and create instance inside it
resource "aws_vpc" "demo" {
  cidr_block = var.vpc-cidr_block
  tags = {
    Name = "my-vpc"
  }
}

# create internet gateway for vpc
resource "aws_internet_gateway" "demo" {
  vpc_id = aws_vpc.demo.id

  tags = {
    Name = "MY-IG"
  }

}
# create an subnet for vpc and instance
resource "aws_subnet" "demo" {
  vpc_id                  = aws_vpc.demo.id
  cidr_block              = var.public-subnet
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnets"
  }
}

# create route table and create route
resource "aws_route_table" "demo" {
  vpc_id = aws_vpc.demo.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo.id
  }

  tags = {
    Name = "aws-route-table"
  }
}

# associate route table with subnet
resource "aws_route_table_association" "name" {
  route_table_id = aws_route_table.demo.id
  subnet_id      = aws_subnet.demo.id

}
# create security group for insance 
resource "aws_security_group" "demo" {
  name   = "instance-security"
  vpc_id = aws_vpc.demo.id

  # allow ssh traffic for instance
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.security-group-ssh]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.security-group-ssh]
  }
  # allow security for outbond service
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.security-group-ssh]
  }
}
# create an ec2 instance inside public subnet
resource "aws_instance" "demo" {
  ami                         = var.aws-ami
  instance_type               = var.aws-instance-type
  subnet_id                   = aws_subnet.demo.id
  vpc_security_group_ids      = [aws_security_group.demo.id]
  associate_public_ip_address = true
  tags = {
    Name = var.instance-name
  }
}
