
variable "fargate_cluster_name" {
  default = "fargate-cluster"
}

variable "fargate_task_name" {
  default = "fargate-task"
}

variable "memory" {
  default = "512"
}

variable "cpu" {
  default = "256"
}

variable "ecs_execution_fargaterole" {
  default = "execution-fargate-role"
}
variable "fargatePolicy" {
  default = "ecs_fargate_policy"
}

variable "fargate_service_name" {
  default = "ecs-fargate-service"
}

variable "requires_compatibilities_fargate_task" {
  default = ["FARGATE"]
}

variable "enable_assign_public_IP" {
  type    = bool
  default = true
}

variable "desired_count" {
  default = 2
}

variable "subnet_a" {
  default = "aws_default_subnet.fargate_subnet_a.id"
}

variable "subnet_b" {
  default = "aws_default_subnet.fargate_subnet_b.id"
}
