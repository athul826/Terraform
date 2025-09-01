resource "aws_security_group" "demo" {
  vpc_id = var.vpc-id
  name   = var.secuirty-group-name

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ingress-cidr]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.egress-cidr]
  }

}
