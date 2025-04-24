variable "vpc_cidr" {
  description = "value for vpc cidr block"

}

variable "vpc_name" {
  description = "assign name for vpc"

} 

variable "subnet_name" {
    description = "name for subnet"
} 
variable "subnet_cidrblock" {
    description = "assign cidr block for subnet"
  
}
variable "subnet_availabilityzone" {
    description = "assign availabiltiy zone for subnet"
  
} 

variable "ineternet_gateway_name" { 
    description = "assign name for internet gateway"
  
} 

variable "route_table_name" { 
    description = "assign name for route table"
  
} 
variable "route_table_cidrblock" { 
    description = "assign cidr block for route table"
  
}
