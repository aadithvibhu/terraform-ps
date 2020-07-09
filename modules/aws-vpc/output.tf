output "vpc_id" {
  value       = aws_vpc.vpc_devops.id
}
output "private_subnet" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.sub_private_devops.id
}

output "public_subnet" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.sub_public_devops.id
}
output "data_subnet" {
  description = "List of IDs of data subnets"
  value       = aws_subnet.sub_data_devops.id
}
