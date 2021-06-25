
variable "fargate_cluster_name" {
  default = "fargate-cluster-1"
}

variable "fargate_task_name" {
  default = "fargate-task-1"
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
