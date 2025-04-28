resource "aws_security_group" "demo" {
  vpc_id = var.secruity_group_vpc_id
  name   = var.secruity_group_name

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.security_group_ingress_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.secruity_group_egress_cidr_block]
  }

}
