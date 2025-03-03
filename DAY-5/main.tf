provider "aws" {
  region = "us-east-1"

}

resource "aws_vpc" "demo" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = var.vpc_tenancy

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "demo" {
  vpc_id = aws_vpc.demo.id
}
resource "aws_subnet" "demo" {
  vpc_id                  = aws_vpc.demo.id
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.subnet_availability
}

# create route table for vpc and instance
resource "aws_route_table" "demo" {
  vpc_id = aws_vpc.demo.id

  route {
    cidr_block = var.route-table-cidr
    gateway_id = aws_internet_gateway.demo.id

  }
  tags = {
    Name = ""
  }

}

# associate route table with subnets 

resource "aws_route_table_association" "demo" {
  route_table_id = aws_route_table.demo.id
  subnet_id      = aws_subnet.demo.id
}

# create security group for instance 
resource "aws_security_group" "demo" {
  vpc_id = aws_vpc.demo.id
  name   = var.securiy-group-name

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.securiy-group-cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.securiy-group-cidr]
  }


}

# create instance for application 
resource "aws_instance" "demo" {
  ami                         = var.ami
  instance_type               = var.insance-type
  subnet_id                   = aws_subnet.demo.id
  associate_public_ip_address = true
  security_groups             = [aws_security_group.demo.id]
  tags = {
    Name = var.instance-name
  }

}
