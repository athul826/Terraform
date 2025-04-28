resource "aws_instance" "demo" {
  ami                         = var.instance_ami1
  instance_type               = var.instance_type1
  subnet_id                   = var.instance_subnet_id1
  vpc_security_group_ids      = [var.instance_security_id1]
  associate_public_ip_address = true

  tags = {
    Name = var.instance_name1
  }

}
