output "vpc-id" {
  value = aws_vpc.demo.id

}

output "subnet-id" {
  value = aws_subnet.demo.id

}

output "instance-public-ip" {
  value = aws_instance.demo.public_ip

}

output "instance-private-ip" {
  value = aws_instance.demo.private_ip

}
