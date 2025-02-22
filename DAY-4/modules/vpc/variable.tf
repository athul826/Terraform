variable "aws-vpc-cidr_block" {
    type = string
    default = "10.0.0.0/16"
  
}

variable "aws-vpc-name" {
    type = string
    default = "my-vpc"
  
}
variable "ig-name" {
    type = string
    default = "my-ig"
  
}

variable "subnet-cidr_block" {
    type = string
    default = "10.0.0.0/24"
  
}
