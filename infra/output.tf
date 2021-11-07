output "registry_id" {
  value = aws_ecr_repository.repository.registry_id
}
output "repository_url" {
  value = aws_ecr_repository.repository.repository_url
}

output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "vpc_cidr_block" {
  value = aws_vpc.main_vpc.cidr_block
}

output "private_subnets" {
  value = aws_subnet.private.*.id
}

output "public_subnets" {
  value = aws_subnet.public.*.id
}