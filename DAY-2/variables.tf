variable "aws-instance-type" {
    description = "aws instance creation"
    type = string
    default = "t2.micro"
  
}

variable "aws-ami" {
    description = "aws-ami creation"
    type = string
    default = "ami-04b4f1a9cf54c11d0"
  
}

variable "instance-name" {
    description = "used to create instance name"
    type = string
    default = "terraform-instance"
  
}