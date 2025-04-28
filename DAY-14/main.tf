# create ec2 instance using terraform  
provider "aws" {
  region = "ap-south-1"

}

variable "vpc_name" {
  description = "assing name for vpc"
  type        = string
  default     = "10.0.0.0/16"

}

variable "vpc_cidr_block" {
  description = "assing cidr value for vpc"

}
resource "aws_vpc" "demo" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = var.vpc_name
  }

}
variable "subnet_name" {
  default = "demo-subnet"

}

variable "subnet_cidrblock" {
  default = "10.0.0.0/24"

}
variable "subnet_availabilityzone" {
  default = "ap-south-1a"

}
# create subnet for vpc 
resource "aws_subnet" "demo" {
  vpc_id                  = aws_vpc.demo.id
  cidr_block              = var.subnet_cidrblock
  availability_zone       = var.subnet_availabilityzone
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet_name
  }

}

variable "internet-gateway-name" {
  default = "my-ig"

}

# create internet gateway for vpc 
resource "aws_internet_gateway" "demo" {
  vpc_id = aws_vpc.demo.id

  tags = {
    Name = var.internet-gateway-name
  }

}
variable "route_table_name" {
  default = "my-route-table"

}
variable "route_table_cidr" {
  default = "0.0.0.0/0"

}

# create route table for vpc 
resource "aws_route_table" "demo" {
  vpc_id = aws_vpc.demo.id

  route {
    gateway_id = aws_internet_gateway.demo.id
    cidr_block = var.route_table_cidr
  }

  tags = {
    Name = var.route_table_name
  }

}

# subnet association with route table 
resource "aws_route_table_association" "demo" {
    route_table_id = aws_route_table.demo.id 
    subnet_id = aws_subnet.demo.id 
  
} 
variable "security_gorup_name" {
    default = "my-security"
  
} 

variable "security_group_ingress_cidr_block" {
    default = "0.0.0.0./0"
  
}
variable "secruity_group_egress_cidr" {
    default = "0.0.0.0/0"
  
}

resource "aws_security_group" "demo" {
    vpc_id = aws_vpc.demo.id 
    name = var.security_gorup_name

    ingress {
        from_port = 22 
        to_port = 22 
        protocol = "tcp"
        cidr_blocks = [var.security_group_ingress_cidr_block]
    } 
    egress {
        from_port = 0 
        to_port = 0 
        protocol = "-1"
        cidr_blocks = var.secruity_group_egress_cidr
    }
  
} 

# create instance 
variable "ami" {
    default = ""
  
} 

variable "instance_type" { 
    default = ""
  
} 

variable "instance_name" {
  
} 

resource "aws_instance" "demo" {
    ami = var.ami 
    instance_type = var.instance_type
    subnet_id = aws_subnet.demo.id 
    associate_public_ip_address = true 
    vpc_security_group_ids = [aws_security_group.demo.id] 

    tags = {
        Name = var.instance_name
    }
  
}
