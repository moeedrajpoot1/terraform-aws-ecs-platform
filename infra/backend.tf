terraform {
  backend "s3" {
    bucket       = "terraform-state-bucket-206"
    region       = "eu-north-1"
    encrypt      = true
    use_lockfile = true
    # `key` is intentionally omitted (partial config). Pass it per environment at init:
    #   terraform init -backend-config="key=dev/terraform.tfstate"
  }
}
