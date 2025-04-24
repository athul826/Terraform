provider "aws" {
  region = "us-east-1"

}
variable "vpc-cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}
variable "vpc-name" {
  type    = string
  default = "demo"

}
variable "vpc-ig" {
  type    = string
  default = "demo-ig"
}

variable "subnet-cidr_block" {
  type    = string
  default = "10.0.0.0/24"

}
variable "subnet-availability_zone" {
  type    = string
  default = "us-east-1a"

}
variable "subnet-name" {
  type    = string
  default = "demo-subnet"

}
# create route table variable for instance 
variable "aws-routetable-name" {
  default = "demo-routetable"

}
variable "aws-route-cidr_block" {
  default = "0.0.0.0/0"

}
variable "aws-security-gorup-name" {
  default = "demo"

}
variable "aws_security_cidr_block" {
  default = "0.0.0.0/0"
}
variable "ami" {
  type    = string
  default = "ami-084568db4383264d4"

}
variable "instance-type" {
  type    = string
  default = "t2.micro"

}
variable "instance-name" {
  type    = string
  default = "demo"

}
output "vpc_id" {
    value = aws_vpc.demo.id
  
} 
output "subnet-id" {
    value = aws_subnet.demo.id
  
}
output "instance-public-id" {
  value = aws_instance.demo.public_ip

}
output "instance-private-id" {
    value = aws_instance.demo.private_ip
  
}

resource "aws_vpc" "demo" {
  cidr_block = var.vpc-cidr_block

  tags = {
    Name = var.vpc-cidr_block
  }
}

resource "aws_internet_gateway" "demo" {
  vpc_id = aws_vpc.demo.id
  tags = {
    Name = var.vpc-ig
  }

}
# crate subnet for instance creation 
resource "aws_subnet" "demo" {
  vpc_id                  = aws_vpc.demo.id
  cidr_block              = var.subnet-cidr_block
  availability_zone       = var.subnet-availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet-name
  }

}
resource "aws_route_table" "demo" {
  vpc_id = aws_vpc.demo.id

  route {
    gateway_id = aws_internet_gateway.demo.id
    cidr_block = var.aws-route-cidr_block
  }

  tags = {
    Name = var.aws-routetable-name
  }


}
# subnet association with route table 
resource "aws_route_table_association" "demo" {
  route_table_id = aws_route_table.demo.id
  subnet_id      = aws_subnet.demo.id
}

# create security group for instance 
resource "aws_security_group" "demo" {
  vpc_id = aws_vpc.demo.id
  name   = var.aws-security-gorup-name

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.aws_security_cidr_block]

  }

  egress {
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_blocks = [var.aws_security_cidr_block]
  }


}


resource "aws_instance" "demo" {
  ami                         = var.ami
  instance_type               = var.instance-type
  subnet_id                   = aws_subnet.demo.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.demo.id]


  tags = {
    Name = var.instance-name
  }

}
