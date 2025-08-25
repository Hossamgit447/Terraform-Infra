module "vpc" {
  source   = "git::https://github.com/Hossamgit447/Terraform-Modules.git//network?ref=master"
  vpc_cidr = var.vpc_cidr
  env      = var.env
}