resource "aws_default_vpc" "fargate_vpc" {
  tags = {
    Name = "fargate_vpc"
  }
}

resource "aws_default_subnet" "fargate_subnet_a" {
  availability_zone = "eu-west-2a"
  tags = {
    Name = "fargate_subnet_a"
  }
}

resource "aws_default_subnet" "fargate_subnet_b" {
  availability_zone = "eu-west-2b"
  tags = {
    Name = "fargate_subnet_b"
  }
}

resource "aws_security_group" "ecs_sg" {
  vpc_id = aws_default_vpc.fargate_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
