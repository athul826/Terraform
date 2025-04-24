resource "aws_security_group" "demo" {
    vpc_id = var.vpc_id_1 
     name = var.security_group_name 

     ingress {
        from_port = 22 
        to_port = 22 
        cidr_blocks = var.ingress_cidr
        protocol = "tcp"
     } 

     egress {
        from_port = 0 
        to_port = 0 
        protocol = "-1" 
        cidr_blocks = var.egress_cidr
     }
  
}