provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

resource "aws_ecs_cluster" "my_ecs_cluster" {
  name = "yanned-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "yanned_task_web" {
  family                = "yanned-task-web"
  container_definitions = file("container_definitions.json")
}

resource "aws_ecs_service" "yanned_service_1" {
  name            = "yanned-service-1"
  cluster         = "${aws_ecs_cluster.my_ecs_cluster.id}"
  task_definition = "${aws_ecs_task_definition.yanned_task_web.id}"
  launch_type     = "EC2"
  desired_count   = 2
}
