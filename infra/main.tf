locals {
  prefix = "fastapi-${var.environment}" # e.g. fastapi-dev
}

# Default VPC + subnets (shared by both services)
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# ECR repositories. These are shared across all environments, so they are
# created ONCE (outside this per-environment state) and only looked up here:
#   aws ecr create-repository --repository-name fastapi-backend
#   aws ecr create-repository --repository-name fastapi-frontend
data "aws_ecr_repository" "backend" {
  name = "fastapi-backend"
}

data "aws_ecr_repository" "frontend" {
  name = "fastapi-frontend"
}

# One ECS cluster per environment
resource "aws_ecs_cluster" "main" {
  name = "${local.prefix}-cluster"
}

# Task execution role shared by both services (pull image + write logs)
resource "aws_iam_role" "ecs_execution" {
  name = "${local.prefix}-ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "ecs-tasks.amazonaws.com" }
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution" {
  role       = aws_iam_role.ecs_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Backend service (FastAPI, port 8000)
module "backend" {
  source = "./modules/ecs-service"

  name               = "fastapi-backend-${var.environment}"
  image              = "${data.aws_ecr_repository.backend.repository_url}:${var.image_tag}"
  container_port     = 8000
  cluster_id         = aws_ecs_cluster.main.id
  execution_role_arn = aws_iam_role.ecs_execution.arn
  vpc_id             = data.aws_vpc.default.id
  subnet_ids         = data.aws_subnets.default.ids
  aws_region         = var.aws_region
  cpu                = var.ecs_task_cpu
  memory             = var.ecs_task_memory
  desired_count      = var.desired_count
  log_retention_days = var.log_retention_days
  os_family          = var.os_family
  cpu_architecture   = var.cpu_architecture
}

# Frontend service (React/Vite served by `serve`, port 3000)
module "frontend" {
  source = "./modules/ecs-service"

  name               = "fastapi-frontend-${var.environment}"
  image              = "${data.aws_ecr_repository.frontend.repository_url}:${var.image_tag}"
  container_port     = 3000
  cluster_id         = aws_ecs_cluster.main.id
  execution_role_arn = aws_iam_role.ecs_execution.arn
  vpc_id             = data.aws_vpc.default.id
  subnet_ids         = data.aws_subnets.default.ids
  aws_region         = var.aws_region
  cpu                = var.ecs_task_cpu
  memory             = var.ecs_task_memory
  desired_count      = var.desired_count
  log_retention_days = var.log_retention_days
  os_family          = var.os_family
  cpu_architecture   = var.cpu_architecture
}

# Outputs (the names the CI/CD workflows target)
output "cluster_name" {
  value = aws_ecs_cluster.main.name
}

output "backend_service" {
  value = module.backend.service_name
}

output "frontend_service" {
  value = module.frontend.service_name
}
