resource "aws_ecs_cluster" "fargate_cluster" {
  name = var.fargate_cluster_name
}

resource "aws_ecs_task_definition" "fargate_task" {
  family                   = var.fargate_task_name
  container_definitions    = file("${path.module}/others/cont_def.json")
  requires_compatibilities = var.requires_compatibilities_fargate_task
  network_mode             = "awsvpc"
  memory                   = var.memory
  cpu                      = var.cpu
  execution_role_arn       = aws_iam_role.ecs_execution_fargaterole.arn
}

resource "aws_ecs_service" "fargate_service" {
  name            = var.fargate_service_name
  cluster         = aws_ecs_cluster.fargate_cluster.id
  task_definition = aws_ecs_task_definition.fargate_task.arn
  launch_type     = "FARGATE"
  desired_count   = var.desired_count

  network_configuration {
    subnets          = ["${aws_default_subnet.fargate_subnet_a.id}", "${aws_default_subnet.fargate_subnet_b.id}"]
    assign_public_ip = var.enable_assign_public_IP
    security_groups  = ["${aws_security_group.ecs_sg.id}"]
  }
}
