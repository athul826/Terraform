provider "aws" {
    region = "us-east-1"
  
}

resource "aws_instance" "demo" {
    ami = var.aws-ami
    instance_type = var.aws-instance-type

    tags = {
        Name = var.instance-name
    }
  
}