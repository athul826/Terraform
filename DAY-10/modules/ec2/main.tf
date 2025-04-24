resource "aws_instance" "demo" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = var.instance_subnet_id
  vpc_security_group_ids      = [var.instance_security_group_id]

  tags = {
    Name = var.instance_name
  }
}
