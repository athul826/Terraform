variable "aws-region" {
    description = "Aws region where resource will be created"
    default = "us-east-1"
  
}

variable "subnet-cidr_block-1a" {
    description = "this is the cidr block for subnet 1a block"
    default = "10.0.1.0/24"
  
}
variable "subnet-cidr-block-1b" {
    description = "this is the cidr block for subnet 1b block"
    default = "10.0.2.0/24"
  
}

variable "availability_zone-1A" {
    description = "this is the Availability zone for 1A"
    default = "us-east-1a"
  
}
variable "availability_zone-1B" {
    description = "this is the Availability zone for 1B"
    default = "us-east-1b"
  
}
variable "ssh-cidr_block" {
    description = "this is the cidr block for ssh 22 port"
    default = "0.0.0.0/0"
  
}
variable "http-cidr-block" {
    description = "this is the cidr block for http"
    default = "0.0.0.0./0"
  
}
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
variable "vpc_cidrblock" {
    description = "vpc creation for aws instance"
    default = "10.0.0.0/16"

}

variable "subnet" {

  
}