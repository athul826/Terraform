output "instance_pulbic_ip" {
  value = aws_instance.demo.public_ip
} 

output "instance_private_ip" { 
    value = aws_instance.demo.private_ip
  
}