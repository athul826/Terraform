output "aws-instance-public-ip" {
  value = aws_instance.demo.public_ip
}

output "aws-instance-private-ip" {
  value = aws_instance.demo.private_ip

}
