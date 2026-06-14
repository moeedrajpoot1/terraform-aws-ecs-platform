# Terraform AWS ECS Platform

A Terraform module for deploying and managing AWS ECS (Elastic Container Service) infrastructure.

## Overview

This repository contains Terraform configurations for setting up a scalable, production-ready ECS platform on AWS.

## Features

- ECS cluster and task definitions
- ALB (Application Load Balancer) integration
- Auto-scaling configuration
- CloudWatch monitoring and logging
- VPC and networking setup

## Prerequisites

- Terraform >= 1.0
- AWS CLI configured with credentials
- AWS account with appropriate permissions

## Usage

```hcl
module "ecs_platform" {
  source = "./"
  
  # Configure your variables
}
```

## Structure

- `main.tf` - Main Terraform configuration
- `variables.tf` - Variable definitions
- `outputs.tf` - Output values
- `terraform.tfvars` - Variable values (customize as needed)

## License

MIT
