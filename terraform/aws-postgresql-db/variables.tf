variable "aws_region" {
  default = "us-east-1"
}

variable "db_name" {
  default = "myappdb"
}

variable "db_username" {
  default = "admin"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "allowed_ip" {
  description = "IP address for DB access"
  default     = "0.0.0.0/0" # За тестови цели
}
