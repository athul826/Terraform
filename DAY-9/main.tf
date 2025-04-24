provider "aws" {
  region = "us-east-1"

}

resource "aws_vpc" "demo" {
  cidr_block = var.vpc_cidirblock

  tags = {
    Name = var.vpc_cidirblock
  }

}

# create subnet for vpc 
resource "aws_subnet" "demo" {
  vpc_id                  = aws_vpc.demo.id
  cidr_block              = var.subnet_cidrblock
  map_public_ip_on_launch = true
  availability_zone       = var.subnet-availability_zone

}

# create internet gateway for vpc 
resource "aws_internet_gateway" "demo" {
  vpc_id = aws_vpc.demo.id

  tags = {
    Name = var.internet-gateway
  }

}

# create routetable for vpc 
resource "aws_route_table" "demo" {
  vpc_id = aws_vpc.demo.id

  route {
    gateway_id = aws_internet_gateway.demo.id
    cidr_block = var.route_table_cidrblock
  }
  tags = {
    Name = var.route-table-name
  }

}

# associate subnet with route table 
resource "aws_route_table_association" "demo" {
  route_table_id = aws_route_table.demo.id
  subnet_id      = aws_subnet.demo.id

}

# create security group for instance 
resource "aws_security_group" "demo" {
  vpc_id = aws_vpc.demo.id
  name   = var.security_group_name

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.securit-ingress-cidrblock]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.security_egrss_cidrblock]
  }

}

# create instance 
resource "aws_instance" "demo" {
  ami                         = var.instance_ami
  instance_type               = var.intance_type
  subnet_id                   = aws_subnet.demo.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.demo.id]

  tags = {
    Name = var.security_group_name
  }
}
