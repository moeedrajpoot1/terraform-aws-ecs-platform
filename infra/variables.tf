variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-north-1"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "image_tag" {
  description = "Image tag Terraform deploys initially. CI redeploys :latest via force-new-deployment."
  type        = string
  default     = "latest"
}

variable "log_retention_days" {
  description = "CloudWatch log retention in days"
  type        = number
  default     = 7
}

variable "ecs_task_cpu" {
  description = "ECS task CPU units (per service)"
  type        = string
  default     = "256"
}

variable "ecs_task_memory" {
  description = "ECS task memory in MB (per service)"
  type        = string
  default     = "512"
}

variable "desired_count" {
  description = "Number of tasks per service"
  type        = number
  default     = 1
}

variable "os_family" {
  description = "Operating system family for ECS tasks"
  type        = string
  default     = "LINUX"
}

variable "cpu_architecture" {
  description = "CPU architecture for ECS tasks"
  type        = string
  default     = "X86_64"
}
