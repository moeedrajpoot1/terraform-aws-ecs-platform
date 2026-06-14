# Apply with:
#   terraform init -backend-config="key=staging/terraform.tfstate"
#   terraform apply -var-file=staging.tfvars
environment        = "staging"
aws_region         = "eu-north-1"
log_retention_days = 7
ecs_task_cpu       = "256"
ecs_task_memory    = "512"
desired_count      = 1
os_family          = "LINUX"
cpu_architecture   = "X86_64"
