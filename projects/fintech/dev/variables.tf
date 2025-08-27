variable "aws_region" {
  description = "AWS region"
  type        = string
}
variable "vpc_cidr" {
  description = "cider for vpc"
  type        = string
}
variable "env" {
  description = "defines the environment"
  type        = string
}
variable "name" {
  description = "The name of the secret in AWS Secrets Manager"
  type        = string
}

variable "azs" {
  type = list(string)
}
