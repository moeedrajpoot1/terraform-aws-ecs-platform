# Apply with:
#   terraform init -backend-config="key=prod/terraform.tfstate"
#   terraform apply -var-file=prod.tfvars
environment        = "prod"
aws_region         = "eu-north-1"
log_retention_days = 30
ecs_task_cpu       = "512"
ecs_task_memory    = "1024"
desired_count      = 1
os_family          = "LINUX"
cpu_architecture   = "X86_64"
