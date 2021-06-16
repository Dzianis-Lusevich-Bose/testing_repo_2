provider "aws" {
  region = "us-east-2"
}

resource "aws_ecs_cluster" "fargate_cluster" {
  name = "fargate-cluster"
}

resource "aws_ecs_task_definition" "fargate_task" {
  family                   = "fargate-task"
  container_definitions    = file("cont_def.json")
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = 512
  cpu                      = 256
  execution_role_arn       = "${aws_iam_role.ecs_execution_fargaterole.arn}"
}

resource "aws_iam_role" "ecs_execution_fargaterole" {
  name               = "ecs-execution-fargaterole"
  assume_role_policy = file("execute_role_fargate.json")
}


resource "aws_ecs_service" "fargate_service" {
  name            = "fargate-service"
  cluster         = "${aws_ecs_cluster.fargate_cluster.id}"
  task_definition = "${aws_ecs_task_definition.fargate_task.id}"
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = ["${aws_default_subnet.default_subnet_a.id}", "${aws_default_subnet.default_subnet_b.id}"]
    assign_public_ip = true
  }

}

resource "aws_default_vpc" "default_vpc" {
}

resource "aws_default_subnet" "default_subnet_a" {
  availability_zone = "us-east-2a"
}

resource "aws_default_subnet" "default_subnet_b" {
  availability_zone = "us-east-2b"
}
