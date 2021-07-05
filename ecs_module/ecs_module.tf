resource "aws_ecs_cluster" "fargate_cluster" {
  name = var.fargate_cluster_name
}

resource "aws_ecs_task_definition" "fargate_task" {
  family                   = var.fargate_task_name
  container_definitions    = var.container_definitions
  requires_compatibilities = var.requires_compatibilities_fargate_task
  network_mode             = "awsvpc"
  memory                   = var.memory
  cpu                      = var.cpu
  execution_role_arn       = var.execution_role_arn
}

resource "aws_ecs_service" "fargate_service" {
  name            = var.fargate_service_name
  cluster         = aws_ecs_cluster.fargate_cluster.id
  task_definition = aws_ecs_task_definition.fargate_task.arn
  launch_type     = var.launch_type
  desired_count   = var.desired_count

  network_configuration {
    subnets          = var.subnets
    assign_public_ip = var.assign_public_ip
    security_groups  = var.security_groups
  }
}
