# ---------------------
# Network Module
# ---------------------
module "network" {
  source = "git::https://github.com/Hossamgit447/terraform-modules.git//modules/network?ref=master"

  aws_region = var.aws_region
  vpc_cidr   = var.vpc_cidr
  azs        = var.azs
}

# ---------------------
# IAM Module
# ---------------------
module "iam" {
  source = "git::https://github.com/Hossamgit447/terraform-modules.git//modules/iam?ref=master"

  env = var.env
}

# ---------------------
# EKS Module
# ---------------------
module "eks" {
  source = "git::https://github.com/Hossamgit447/terraform-modules.git//modules/eks?ref=master"

  env                = var.env
  cluster_role_arn   = module.iam.eks_cluster_role_arn
  public_subnet_ids  = module.network.public_subnet_ids
  private_subnet_ids = module.network.private_subnet_ids
}
module "db_password_secret" {
  source      = "git::https://github.com/Hossamgit447/terraform-modules.git//modules/secret_manger?ref=master"
  name        = var.name
  description = "Secret container for MyApp DB password"
}
