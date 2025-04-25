output "vpc_id" {
  value = aws_vpc.demo.id

}

output "subnet_id" {
  value = aws_subnet.demo.id

}

output "instance_id" {
  value = aws_instance.demo.id

}

output "instance_public_id" {
  value = aws_instance.demo.public_ip

}

output "instance_private_ip" {
  value = aws_instance.demo.private_ip

}
