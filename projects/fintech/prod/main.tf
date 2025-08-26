module "vpc" {
  source   = "git::https://github.com/Hossamgit447/terraform-modules.git//modules/network?ref=master"
  vpc_cidr = var.vpc_cidr
  env      = var.env
}
module "db_password_secret" {
  source      = "git::https://github.com/Hossamgit447/terraform-modules.git//modules/secret_manager?ref=master"
  name        = var.name
  description = "Secret container for MyApp DB password"
}
