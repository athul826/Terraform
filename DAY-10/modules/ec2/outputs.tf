output "instance_ip" {
  value = aws_instance.demo.id

}
output "instance_public_ip" {
  value = aws_instance.demo.public_ip

}

output "instance_private_ip" {
  value = aws_instance.demo.private_ip

}
