resource "aws_instance" "demo" {
    ami = var.ami
    instance_type = var.instance_type
    subnet_id = var.instance_subnet_id
    associate_public_ip_address = true 
    vpc_security_group_ids = [var.instance_security_group_id]

    tags = {
        Name = var.instance_name
    }
  
}