provider "aws" {
  region = "us-east-1"

}

variable "instance_type" {
  description = "type of ec2 instance"
  type        = string
  default     = "t2.micro"
}
variable "ami_id" {
  description = "ami for ec2 instance"
  type        = string
  default     = "ami-085ad6ae776d8f09c"

}

variable "instance_name" {
  description = "name tag for instance"
  type        = string
  default     = "terraform-instance"

}

# create an instance using variable
resource "aws_instance" "demo" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}
output "instance_public_ip" {
  description = "the public ip of instance"
  value       = aws_instance.demo.public_ip
}
