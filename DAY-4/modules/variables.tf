variable "ami-id" {
  description = "ami id for the instance"
  type        = string

}

variable "instance-type" {
  description = "instance id for the instance"
  type        = string
  default = "t2.micro"

}

variable "instance-name" {
  default = "name tag for the insance"
  type    = string
}

variable "instance-name" {
    type = string
    default = "terraform"
  
}
