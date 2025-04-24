variable "vpc_id_1" {
    description = "assign vpc id for security group"
  
}
variable "security_group_name" { 
    description = "value for secruriy group"
  
} 

variable "ingress_cidr" { 
    description = "associate cidr for ingress"
  
} 
 
variable "egress_cidr" {
    description = "associate cidr for egress"
  
}