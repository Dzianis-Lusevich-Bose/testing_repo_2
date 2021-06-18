variable "aws_access_key_id" {
  default = ""
}

variable "aws_secret_access_key" {
  default = ""
}

variable "region" {
  default = "us-east-2"
}

variable "fargate_cluster_name" {
  default = "fargate-cluster"
}

variable "fargate_task_name" {
  default = "fargate-task"
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
