provider "aws" {
  region = "us-east-1"

}

variable "vpc-cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}
variable "subnet-cidr_block" {
  type    = string
  default = "10.0.1.0/24"

}

variable "subnet-availability" {
  type    = string
  default = "us-east-1a"

}

variable "subnet-name" {
  type    = string
  default = "demo-vpc"

}

variable "route-table_cidr" {
  type    = string
  default = "0.0.0.0/0"

}

variable "route-table-name" {
  type    = string
  default = "public-subnet-1a"

}

variable "ingress-cidr_block" {
  default = ["0.0.0.0/0"]

}

variable "egress-cidr-block" {
  default = ["0.0.0.0/0"]

}

variable "securiy-group-name" {
  default = "demo-vpc"

}

variable "ami" {
  type    = string
  default = "ami-0cb91c7de36eed2cb"

}

variable "instance-type" {
  type    = string
  default = "t2.micro"
}

variable "instance-name" {
  type    = string
  default = "demo-instance"

}

output "subnet-id" {
  value = aws_subnet.demo.id

}

output "vpc-id" {
  value = aws_vpc.demo.id

}

output "instance-public-ip" {
  value = aws_instance.dmeo.public_ip

}

output "instance_private-ip" {
  value = aws_instance.dmeo.private_ip

}
# create vpc for instance
resource "aws_vpc" "demo" {
  cidr_block = var.vpc-cidr_block

  tags = {
    Name = "demo-vpc"
  }

}

# create internet gateway 
resource "aws_internet_gateway" "demo" {
  vpc_id = aws_vpc.demo.id

  tags = {
    Name = "my-internet-gateway"
  }

}

# create subnets for instance 
resource "aws_subnet" "demo" {
  vpc_id                  = aws_vpc.demo.id
  cidr_block              = var.subnet-cidr_block
  availability_zone       = var.subnet-availability
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet-name
  }

}

# create route table for instance 
resource "aws_route_table" "demo" {
  vpc_id = aws_vpc.demo.id

  route {
    cidr_block = var.route-table_cidr
    gateway_id = aws_internet_gateway.demo.id
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
  name   = var.securiy-group-name

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ingress-cidr_block
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.egress-cidr-block
  }

}

# create key pair for intance 
resource "aws_key_pair" "demo" {
  key_name   = "demo-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

# create instance 
resource "aws_instance" "dmeo" {
  ami                         = var.ami
  instance_type               = var.instance-type
  subnet_id                   = aws_subnet.demo.id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.demo.key_name
  vpc_security_group_ids      = [aws_security_group.demo.id]

  tags = {
    Name = var.instance-name
  }

  # use file provisioner to copy welcome.sh file into instance 
  provisioner "file" {
    source      = "/d/Terraform/DAy-6/welcome.sh"
    destination = "/home/ubuntu/welocme.sh"

  }

  # use reomte provisioner to execute commands inside instance 
  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /home/ubuntu/welcome.sh",
      "sudo /home/ubuntu/welcome.sh"

    ]

  }

  # ssh to the instance 
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }

}
