output "instance_id_public" {
  value = aws_instance.demo.public_ip

}

output "instance_id_private" {
  value = aws_instance.demo.private_ip
}
