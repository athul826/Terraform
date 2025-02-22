resource "aws_instance" "demo" {
  ami           = var.ami-id
  instance_type = var.instance-type

  tags = {
    Name = var.instance-name
  }

}
