resource "aws_instance" "demo" {
  ami                         = var.ami
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.aws_security_group]

  tags = {
    Name = var.instance_name
  }

}
