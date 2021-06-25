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

resource "aws_iam_role" "ecs_execution_fargaterole" {
  name               = var.ecs_execution_fargaterole
  assume_role_policy = file("${path.module}/others/execute_role_fargate.json")
}

resource "aws_iam_policy" "fargatePolicy" {
  name   = var.fargatePolicy
  policy = file("${path.module}/others/fargate_policy.json")
}

resource "aws_iam_role_policy_attachment" "fargate_attachment" {
  role       = aws_iam_role.ecs_execution_fargaterole.name
  policy_arn = aws_iam_policy.fargatePolicy.arn
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

resource "aws_default_vpc" "fargate_vpc" {
  tags = {
    Name = "fargate_vpc"
  }
}

resource "aws_default_subnet" "fargate_subnet_a" {
  availability_zone = "eu-west-2a"
  tags = {
    Name = "fargate_subnet_a"
  }
}

resource "aws_default_subnet" "fargate_subnet_b" {
  availability_zone = "eu-west-2b"
  tags = {
    Name = "fargate_subnet_b"
  }
}

resource "aws_security_group" "ecs_sg" {
  vpc_id = aws_default_vpc.fargate_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
