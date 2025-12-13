terraform {
  backend "s3" {
    bucket = "terraform-692614315984-statefile"
    key = "env:/dev/rds/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "692614315984-terraform-lock"
  }
}