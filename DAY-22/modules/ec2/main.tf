resource "aws_instance" "demo" {
  ami                         = var.ami
  instance_type               = var.instance_type
  associate_public_ip_address = true
  security_groups             = [var.security_groups]
  subnet_id                   = var.subnet_id

  tags = {
    Name = var.instance_name

  }

}
