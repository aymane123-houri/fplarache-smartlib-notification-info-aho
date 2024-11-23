provider "aws" {
  region = var.aws_region
}


resource "aws_ecr_repository" "notification_repo" {
  name                = var.ecr_repository_name
  image_tag_mutability = "MUTABLE"
}


resource "aws_ecs_cluster" "notification_cluster" {
  name = var.ecs_cluster_name
}


resource "aws_ecs_task_definition" "app_task" {
  family                = var.ecs_task_family
  container_definitions = <<DEFINITION
[
  {
    "name": "app",
    "image": "${aws_ecr_repository.notification_repo.repository_url}:latest",
    "memory": 512,
    "cpu": 256,
    "essential": true
  }
]
DEFINITION
requires_compatibilities = ["FARGATE"]
network_mode            = "awsvpc"
memory                 = "512"
cpu                    = "256"
execution_role_arn     = aws_iam_role.ecs_task_execution.arn
}


resource "aws_ecs_service" "app_service" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.notification_cluster.id
  task_definition = aws_ecs_task_definition.app_task.arn
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids
    assign_public_ip = true
  }

  desired_count = 1
}


resource "aws_iam_role" "ecs_task_execution" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { 
            Service = "ecs-tasks.amazonaws.com" 
        }
        Action    = "sts:AssumeRole"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "ecs_task_execution_attachment" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
