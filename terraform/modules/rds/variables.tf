variable "local_name" {
  type = map(string)
}

variable "vpc_id" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "db_username_parameter" {
  type = string
}

variable "db_password_parameter" {
  type = string
}
