variable "aws-instance-type" {
  description = "used to create aws instance"
  type        = string
}

variable "aws-ami" {
  description = "ami for instance"
  type        = string
}

variable "instance-name" {
  type = string

}

variable "vpc-cidr_block" {
  type = string

}
variable "public-subnet" {
  description = "creating public subnet us-east-1"
  type        = string
}

variable "security-group-ssh" {
    type = string
}
