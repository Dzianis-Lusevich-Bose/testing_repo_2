output "service_role_cluster" {
  value = aws_ecs_service.fargate_service.cluster
}
output "service_role_id" {
  value = aws_ecs_service.fargate_service.id
}

output "service_role_iam_role" {
  value = aws_ecs_service.fargate_service.iam_role
}

