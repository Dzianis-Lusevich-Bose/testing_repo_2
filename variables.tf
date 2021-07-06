
variable "fargate_cluster_name" {
  type = string
}
variable "fargate_task_name" {
  type = string
}
variable "fargate_service_name" {
  type = string
}
variable "requires_compatibilities_fargate_task" {
  type = list
}
variable "launch_type" {
  type = string
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
variable "enable_assign_public_IP" {
  type    = bool
}
variable "region" {
  type = string
}
variable "ecs_execution_fargaterole" {
  type = string
}
variable "fargatePolicy" {
  type = string
}
variable "network_mode" {
  type = string
}