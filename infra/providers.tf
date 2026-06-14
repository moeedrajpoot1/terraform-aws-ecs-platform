provider "aws" {
  region = var.aws_region

  # Applied automatically to every taggable resource.
  default_tags {
    tags = {
      Environment = var.environment
      Project     = "fastapi"
      ManagedBy   = "terraform"
    }
  }
}
