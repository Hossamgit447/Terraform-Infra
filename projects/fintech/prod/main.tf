module "vpc" {
  source   = "git::https://github.com/Hossamgit447/terraform-modules.git//modules/network?ref=master"
  vpc_cidr = var.vpc_cidr
  env      = var.env
}
module "db_password_secret" {
  source      = "git::https://github.com/Hossamgit447/terraform-modules.git//secret_manager?ref=main"
  name        = var.name
  description = "Secret container for MyApp DB password"
}