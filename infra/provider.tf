terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.40.0"
    }
  }
  backend "s3" {
    bucket = "sjfuentes-tfstate"
    key    = "sjfuentes-dev/terraform_state"
    region = "eu-central-1"

    dynamodb_table = "sjfuentes-tfstate-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      ManagedBy   = "Terraform"
      Project     = var.prefix
      Environment = "Dev"
    }
  }
}
