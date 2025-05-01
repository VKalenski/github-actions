variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "eu-west-3"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-07d9b9ddc6cd8dd30"
}

variable "key_name" {
  description = "Name of the SSH key to register in AWS"
  type        = string
  default     = "aws_terraform_key"
}

variable "public_key_path" {
  description = "Path to the SSH public key file"
  type        = string
  default     = "~/.ssh/aws_terraform_key.pub"
}

variable "security_group_name" {
  description = "Name prefix for the security group"
  type        = string
  default     = "allow-ssh"
}
