provider "aws" {
  region = "us-east-1"

}
variable "ami" {
  type    = string
  default = "ami-084568db4383264d4"

}
variable "instance-type" {
  type    = string
  default = "t2.micro"

}
variable "name" {
  type    = string
  default = "demo"

}
output "instance-id" {
  value = ""

}

resource "aws_instance" "demo" {
  ami           = var.ami
  instance_type = var.instance-type

  tags = {
    Name = var.name
  }

}
