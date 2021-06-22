provider "aws" {
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  region     = var.region
}


module "ecs_fargate_cluster" {
  source = "../"
}

output "ecs_fargate_cluster" {
  value = module.ecs_fargate_cluster
}
