output "CIDR_block_of_VPC" {
  value = aws_default_vpc.default_vpc.cidr_block
}

output "task_definition_arn" {
  value = aws_ecs_task_definition.fargate_task.id
}

output "iam_tole_id" {
  value = aws_iam_role.ecs_execution_fargaterole.arn
}

output "service_role_id" {
  value = aws_ecs_service.fargate_service.id
}

output "service_role_cluster" {
  value = aws_ecs_service.fargate_service.cluster
}

output "service_role_iam_role" {
  value = aws_ecs_service.fargate_service.iam_role
}

output "subnet_a_id" {
  value = aws_default_subnet.default_subnet_a.id
}

output "subnet_a_cidr_block" {
  value = aws_default_subnet.default_subnet_a.cidr_block
}

output "subnet_b_id" {
  value = aws_default_subnet.default_subnet_b.id
}

output "subnet_b_cidr_block" {
  value = aws_default_subnet.default_subnet_b.cidr_block
}
