output "instance_public_ip" {
  value = aws_instance.demo.public_ip

}

output "instance_private_ip" {
  value = aws_instance.demo.private_ip

}
output "vpc_id" {
  value = aws_vpc.demo.id

}

output "subnet_id" {
  value = aws_subnet.demo.id

}
