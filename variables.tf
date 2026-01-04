variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "bucket" {
  default = "meu-terraform-states-soat"  
}

variable "local_name" {
  description = "Infra stack/cluster name and Environent for resources local name"
  type        = map(string)
  default = {
    name = "lanchonete-app",
    env  = "dev"
  }
}

variable "vpc_cidr_block" {
  description = "Main VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_subnets_count" {
  description = "no. of subnets to launch"
  type        = number
  default     = 2 # For EKS, you need at least two availability zones??
}