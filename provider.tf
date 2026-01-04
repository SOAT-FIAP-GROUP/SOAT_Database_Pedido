provider "aws" {
  region = local.region
}

terraform {
  backend "s3" {
    bucket         = "meu-terraform-states-soat"
    key            = "env:/dev/rds/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks-soat"
  }
}