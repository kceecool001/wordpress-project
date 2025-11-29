output "ec2_id" {
  value = aws_instance.main.id
}

output "ec2_public_ip" {
  value = aws_instance.main.public_ip
}

output "ec2_private_ip" {
  value = aws_instance.main.private_ip
}

output "ec2_sg_id" {
  value = aws_security_group.ec2_sg.id
}