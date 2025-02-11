output "instance-public-ip" {
    value = aws_instance.demo.public_ip

}

output "instance-private-ip" {
    value = aws_instance.demo.private_ip
  
}