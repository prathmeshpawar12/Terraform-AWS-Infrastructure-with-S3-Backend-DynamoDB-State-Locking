# Outputs For Count
# output is also a type of block

# output "ec2_public_ip" {
#   value = aws_instance.my-instance.public_ip
# }

# output "ec2_public_dns" {
#   value = aws_instance.my-instance.public_dns
# }

# output "ec2_private_ip" {
#   value = aws_instance.my-instance.private_ip
# }


# Outputs For For_Each

# Output for Public IPs
output "ec2_public_ip" {
  value = [
    for instance in aws_instance.my-instance : instance.public_ip
  ]
}

# Output for Public DNS
output "ec2_public_dns" {
  value = [
    for instance in aws_instance.my-instance : instance.public_dns
  ]
}

# Output for Private IPs
output "ec2_private_ip" {
  value = [
    for instance in aws_instance.my-instance : instance.private_ip
  ]
}

# Output for Private DNS
output "ec2_private_dns" {
  value = [
    for instance in aws_instance.my-instance : instance.private_dns
  ]
}