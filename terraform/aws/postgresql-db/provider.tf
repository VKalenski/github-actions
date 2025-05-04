provider "aws" {
  region = var.aws_region
}

resource "random_password" "rds_password" {
  length  = 16
  special = true
}
