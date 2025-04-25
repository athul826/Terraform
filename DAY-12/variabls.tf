variable "vpc_name" {
  default = "demo-vpc"

}

variable "vpc_cidr" {
  default = "10.0.0.0/16"

}

variable "subnet_name" {
  default = "demo_subnet"
}

variable "subnet_cidrblock" {
  default = "10.0.0.0/24"

}

variable "subnet_availabilityzone" {
  default = "us-east-1a"

}

variable "aws_internet_gateway_name" {
    default = "my-ig"
  
}

variable "aws_route_table_name" {
    default = "demo-route-table"
  
} 

variable "route_table_cidr" {
    default = "0.0.0.0/0"
  
}

variable "security_group_name" {
    default = "demo-security"
  
} 

variable "security_ingress_cidr" {
    default = "0.0.0.0/0"
  
} 

variable "security_egress_cidr" {
    default = "0.0.0.0/0"
  
} 

variable "ami" {
    default = "ami-084568db4383264d4"
  
} 

variable "instance_type" { 
    default = "t2.micro"
  
} 

variable "instance_name" {
    default = "demo_instance"
  
}