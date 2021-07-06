output "subnet_a_cidr_block" {
  value = aws_default_subnet.fargate_subnet_a.cidr_block
}

output "subnet_b_cidr_block" {
  value = aws_default_subnet.fargate_subnet_b.cidr_block
}

output "CIDR_block_of_VPC" {
  value = aws_default_vpc.fargate_vpc.cidr_block
}

output "service_role_cluster" {
  value = aws_ecs_service.fargate_service.cluster
}
output "service_role_id" {
  value = aws_ecs_service.fargate_service.id
}

output "service_role_iam_role" {
  value = aws_ecs_service.fargate_service.iam_role
}
