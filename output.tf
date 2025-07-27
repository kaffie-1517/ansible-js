output "ec2_public_ip" {

  value = [
  for instance in aws_instance.my-instance : instance.public_ip
  ]
}

output "ec2_public_dns" {

  value = [
  for instance in aws_instance.my-instance : instance.public_dns
  ]
}