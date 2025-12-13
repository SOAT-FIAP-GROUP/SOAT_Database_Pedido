variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "bucket" {
  type    = string
  default = "terraform-692614315984-statefile"
}

variable "local_name" {
  type = map(string)
  default = {
    name = "lanchonete-app"
    env  = "dev"
  }
}

variable "vpc_subnets_count" {
  type    = number
  default = 2
}