provider "aws" {
  region = var.aws_region # using variable for the region
}

# define variables
variable "aws_region" {
    description = "aws region where resource will be created"
    type = string
    default = "us-east-1"
}

variable "instance_type" {
    description = "type of ec2 instance"
    type = string
    default = "t2.micro"

}

variable "ami_id" {
    description = "ami id for the instance"
    type = string
    default = "ami-085ad6ae776d8f09c"
  
}

variable "instance_name" {
    description = "name for the instance"
    type = string
    default = "terraform-instance"
  
}

# create ec2 instance using variables

resource "aws_instance" "example1" {
    ami = var.ami_id
    instance_type = var.instance_type

    tags = {
        Name = var.instance_name

    }
}

# output the public ip of the instance
output "instance_public_ip" {
    description = "the public ip address of the instance"
    value = aws_instance.example1.public_ip
}