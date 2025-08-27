terraform {
  backend "s3" {
    bucket       = "hossam-prod-s3-statefile"
    key          = "prod.tfstate"
    region       = "us-east-1"
  }

  required_version = ">= 1.8.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}





