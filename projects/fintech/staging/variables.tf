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
variable "node_group_desired_size" {
  type    = number
  default = 2
}

variable "node_group_min_size" {
  type    = number
  default = 1
}

variable "node_group_max_size" {
  type    = number
  default = 3
}

variable "node_group_instance_types" {
  type    = list(string)
  default = ["t2.micro"]
}

