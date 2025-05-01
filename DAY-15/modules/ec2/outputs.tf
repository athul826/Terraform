output "instance_public_id" {
    value = aws_instance.demo.public_ip
  
}
output "instance_private_ip" {
    value = aws_instance.demo.private_ip
  
}