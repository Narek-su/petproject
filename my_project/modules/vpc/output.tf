output "vpc" {
  value = aws_vpc.vpc.id
}

output "subnet" {
  value = aws_subnet.public_subnet[*].id
}

output "rt" {
  value = aws_route_table.public_rt
}

