output "instance-public-ip" {
  value = aws_instance.demo.private_ip

}
