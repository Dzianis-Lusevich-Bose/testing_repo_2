provider "aws" {
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  region     = var.region
}

resource "aws_ecr_repository" "fargate_repo" {
  name = "repo-for-fargate"
}

resource "aws_ecs_cluster" "fargate_cluster" {
  name = var.fargate_cluster_name
}

resource "aws_ecs_task_definition" "fargate_task" {
  family                   = var.fargate_task_name
  container_definitions    = file("./json_files/cont_def.json")
  requires_compatibilities = var.requires_compatibilities_fargate_task
  network_mode             = "awsvpc"
  memory                   = 512
  cpu                      = 256
  execution_role_arn       = "${aws_iam_role.ecs_execution_fargaterole.arn}"
}

resource "aws_iam_role" "ecs_execution_fargaterole" {
  name               = "ecs-execution-fargaterole"
  assume_role_policy = file("./json_files/execute_role_fargate.json")
}


resource "aws_ecs_service" "fargate_service" {
  name            = "fargate-service"
  cluster         = "${aws_ecs_cluster.fargate_cluster.id}"
  task_definition = "${aws_ecs_task_definition.fargate_task.id}"
  launch_type     = "FARGATE"
  desired_count   = var.desired_count

  network_configuration {
    subnets          = ["${aws_default_subnet.default_subnet_a.id}", "${aws_default_subnet.default_subnet_b.id}"]
    assign_public_ip = var.enable_assign_public_IP
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
