provider "aws" {
  region = "us-east-1"

}
# create vpc
resource "aws_vpc" "my_vpc" {
  cidr_block       = "10.0.0.0/16"
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

# create public subnets on us-east-1a
resource "aws_subnet" "public-1a" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

# create public subnets on us-east-1b
resource "aws_subnet" "public-1b" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

}

# create route table for both public subnets
resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc-ig.id
  }
}
# associate subnet-1a with routetable
resource "aws_route_table_association" "public-subnet-1a" {
  subnet_id      = aws_subnet.public-1a.id
  route_table_id = aws_route_table.public_route.id
}
# # associate subnet-1b with routetable
resource "aws_route_table_association" "public-subnet-1b" {
  subnet_id      = aws_subnet.public-1b.id
  route_table_id = aws_route_table.public_route.id

}

# create security group
resource "aws_security_group" "my-security" {
  vpc_id = aws_vpc.my_vpc.id
  name   = "my-security"

  ingress {
    description = "Allow incoming HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow incoming traffic for ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# create ec2 instance for public subnet-1a
resource "aws_instance" "public-1a" {
  ami                         = "ami-04b4f1a9cf54c11d0"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public-1a.id
  vpc_security_group_ids      = [aws_security_group.my-security.id]
  associate_public_ip_address = true

  tags = {
    Name = "terraform-intance-1a"
  }
}

# create ec2 instance for public-1b availabilty
resource "aws_instance" "public-1b" {
  ami                         = "ami-04b4f1a9cf54c11d0"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public-1b.id
  vpc_security_group_ids      = [aws_security_group.my-security.id]
  associate_public_ip_address = true

  tags = {
    Name = "terraform-instance-1b"
  }
}

# Output the public-instance-1a IP addresses of the EC2 instances
output "instance_1a_public_ip" {
  description = "Public IP address of the EC2 instance in subnet-1a"
  value       = aws_instance.public-1a.public_ip
}
# Output the public-instance-1a IP addresses of the EC2 instances
output "instance_1b_public-ip" {
  description = "Public ip address of the ec2 instance in subent-1b"
  value       = aws_instance.public-1b.public_ip
}


