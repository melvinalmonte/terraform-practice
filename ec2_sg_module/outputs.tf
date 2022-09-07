output "ec2_instance_id" {
  value = aws_instance.my_ec2.id
}

output "ec2_public_ip" {
  value = aws_instance.my_ec2.public_ip
}

output "ec2_security_group_id" {
  value = aws_security_group.my_app_security_group.id
}