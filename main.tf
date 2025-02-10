provider "aws" {
    region = us-east-1
  
}

resource "aws_instance" "example" {
    ami = "ami-00bb6a80f01f03502"
    instance_type = "t2.micro"

    tags = {
        Name = "myTerraformInstance"
}
}