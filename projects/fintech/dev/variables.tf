variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
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