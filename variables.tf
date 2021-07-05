
variable "fargate_cluster_name" {
  default = "fargate-cluster"
}

variable "fargate_task_name" {
  default = "fargate-task"
}

variable "fargate_service_name" {
  default = "ecs-fargate-service"
}

variable "requires_compatibilities_fargate_task" {
  default = ["FARGATE"]
}
variable "launch_type" {
  default = "FARGATE"
}

variable "cpu" {
  type = number
}
variable "memory" {
  type = number
}

variable "desired_count" {
  type = number
}

variable "execution_role_arn" {
  type = string
}

variable "container_definitions" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "security_groups" {
  type = list(string)
}

variable "assign_public_ip" {
  type    = bool
}