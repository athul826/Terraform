variable "aws_vpc_name" { 
    description = "creating name for vpc"
  
} 
variable "vpc_cidirblock" {
    description = "creating aws vpc cidr block"
  
}

variable "subnet_name" { 
    description = "creating name for subnet"
  
}

variable "subnet_cidrblock" {
    description = "creating cidrblock"
  
}

variable "subnet-availability_zone" { 
    description = "creating availabilityzone"
  
} 

variable "internet-gateway" {
    description = "creating internet gaeway for vpc"
  
}

variable "route_table_cidrblock" {
    description = "allocating cidr block for route table"
  
} 

variable "route-table-name" {
    description = "assign name for route table"
}

variable "security_group_name" { 
    description = "assign name for security group"
  
} 

variable "securit-ingress-cidrblock" {
    description = "allocating cidrblock for ingress rule"  
}

variable "security_egrss_cidrblock" {
    description = "allocatin cidrblock for egrss rule"
  
} 
variable "instance_ami" {
    description = "assign ami for instance"
  
} 
variable "intance_type" {
    description = "assign intance_type"
  
} 
variable "instance_name" {
  description = "assing name for instance"
}