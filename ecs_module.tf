resource "aws_ecs_cluster" "fargate_cluster" {
  name = var.fargate_cluster_name
}

resource "aws_ecs_task_definition" "fargate_task" {
  family                   = var.fargate_task_name
  container_definitions    = file("${path.module}/others/cont_def.json")
  requires_compatibilities = var.requires_compatibilities_fargate_task
  network_mode             = "awsvpc"
  memory                   = 512
  cpu                      = 256
  execution_role_arn       = aws_iam_role.ecs_execution_fargaterole.arn
}

resource "aws_iam_role" "ecs_execution_fargaterole" {
  name               = "ecs-execution-fargaterole"
  assume_role_policy = file("${path.module}/others/execute_role_fargate.json")
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = aws_iam_role.ecs_execution_fargaterole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_service" "fargate_service" {
  name            = "fargate-service"
  cluster         = aws_ecs_cluster.fargate_cluster.id
  task_definition = aws_ecs_task_definition.fargate_task.arn
  launch_type     = "FARGATE"
  desired_count   = var.desired_count

  network_configuration {
    subnets          = ["${aws_default_subnet.fargate_subnet_a.id}", "${aws_default_subnet.fargate_subnet_b.id}"]
    assign_public_ip = var.enable_assign_public_IP
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
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
