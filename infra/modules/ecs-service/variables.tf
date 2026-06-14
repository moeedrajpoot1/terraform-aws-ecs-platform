variable "name" {
  description = "Service name, e.g. fastapi-backend-dev"
  type        = string
}

variable "image" {
  description = "Full container image URL including tag"
  type        = string
}

variable "container_port" {
  description = "Port the container listens on"
  type        = number
}

variable "cluster_id" {
  description = "ECS cluster ID to run in"
  type        = string
}

variable "execution_role_arn" {
  description = "ECS task execution role ARN"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the security group"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets to place tasks in"
  type        = list(string)
}

variable "aws_region" {
  description = "AWS region (for log configuration)"
  type        = string
}

variable "cpu" {
  description = "Task CPU units"
  type        = string
}

variable "memory" {
  description = "Task memory in MB"
  type        = string
}

variable "desired_count" {
  description = "Number of tasks to run"
  type        = number
  default     = 1
}

variable "log_retention_days" {
  description = "CloudWatch log retention in days"
  type        = number
  default     = 7
}

variable "os_family" {
  description = "Operating system family"
  type        = string
  default     = "LINUX"
}

variable "cpu_architecture" {
  description = "CPU architecture"
  type        = string
  default     = "X86_64"
}
