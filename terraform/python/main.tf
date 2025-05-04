provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "ci_cd_logs" {
  bucket = "ci-cd-pipeline-logs-example"
}