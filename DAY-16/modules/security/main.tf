resource "aws_security_group" "demo" {
    vpc_id = var.vpc_id
    name = var.secruity_group_name

    ingress {
        from_port = 22 
        to_port = 22 
        protocol = "tcp"
        cidr_blocks = [var.security_ingress_cidr]
    }

    egress {
        from_port = 0 
        to_port = 0
        protocol = "-1"
        cidr_blocks = [var.secruity_egress_cidr]
    }
  
}