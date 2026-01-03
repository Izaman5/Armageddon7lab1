# Terraform configuration block
# This defines the minimum Terraform version and required providers
terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# AWS Provider configuration
# This tells Terraform how to connect to AWS
provider "aws" {
  region  = var.aws_region
  profile = "default"
}

# resource "aws_secretsmanager_secret" "db_password" {
#   name = "dev/mysql/password"
# }

# resource "aws_secretsmanager_secret_version" "db_password_version" {
#   secret_id = aws_secretsmanager_secret.db_password.id
#   secret_string = var.db_password
# }