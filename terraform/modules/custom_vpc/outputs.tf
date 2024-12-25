output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_a_id" {
  value = aws_subnet.public_1.id
}

output "public_subnet_b_id" {
  value = aws_subnet.public_2.id
}

output "private_subnet_a_id" {
  value = aws_subnet.private_1.id
}

output "private_subnet_b_id" {
  value = aws_subnet.private_2.id
}

output "bastion_host_sg_id" {
  value = aws_security_group.bastion_host.id
}


output "database_sg_id" {
  value = aws_security_group.database.id
}
