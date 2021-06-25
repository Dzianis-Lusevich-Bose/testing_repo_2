resource "aws_iam_role" "ecs_execution_fargaterole" {
  name               = var.ecs_execution_fargaterole
  assume_role_policy = file("${path.module}/others/execute_role_fargate.json")
}

resource "aws_iam_policy" "fargatePolicy" {
  name   = var.fargatePolicy
  policy = file("${path.module}/others/fargate_policy.json")
}

resource "aws_iam_role_policy_attachment" "fargate_attachment" {
  role       = aws_iam_role.ecs_execution_fargaterole.name
  policy_arn = aws_iam_policy.fargatePolicy.arn
}
