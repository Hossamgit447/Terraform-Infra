module "vpc" {
  source   = "git::https://github.com/Hossamgit447/terraform-modules.git//modules/network?ref=master"
  vpc_cidr = var.vpc_cidr
  env      = var.env
}