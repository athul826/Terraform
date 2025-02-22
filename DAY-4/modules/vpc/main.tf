provider "aws" {
  region = "us-east-1"

}

resource "aws_vpc" "demo" {
  cidr_block = var.aws-vpc-cidr_block
  tags = {
    Name = "my-vpc"
  }

}

# create internet gateway and attach it to the vpc
resource "aws_internet_gateway" "my-ig" {
  vpc_id = aws_vpc.demo.id

  tags = {
    Name = var.ig-name
  }

}

# create subnets for instancd
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.demo.id
  cidr_block              = var.subnet-cidr_block
  availability_zone       = "us-east-1"
  map_public_ip_on_launch = true

  tags = {
    Name = "my-subnet-public"
  }

}

# create route table 
resource "aws_route_table" "my_route_table_" {
  vpc_id = aws_vpc.demo.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-ig.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# associate public subnet with public route table
resource "aws_route_table_association" "demo" {
  route_table_id = aws_route_table.my_route_table_.id
  subnet_id      = aws_subnet.public.id

}
