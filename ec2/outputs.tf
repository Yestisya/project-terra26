output "ec2_instance_id" {
  value = aws_instance.project_terra26_ec2.id
}

output "ec2_public_ip" {
  value = aws_instance.project_terra26_ec2.public_ip
}

output "ec2_public_dns" {
  value = aws_instance.project_terra26_ec2.public_dns
}