terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.28.0"
    }
  }

  # S3 Backend for storing Terraform state
  backend "s3" {
    bucket         = "my-terraform-state-bucket-12345"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock-table"
  }

  # Note:
  # Whenever you change or add anything in the terraform block,
  # you must run: terraform init again
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}