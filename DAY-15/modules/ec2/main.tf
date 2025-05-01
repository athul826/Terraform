resource "aws_instance" "demo" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.security_group_id]

  tags = {
    Name = var.instance_name
  }

}
