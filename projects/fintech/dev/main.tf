# ---------------------
# Network Module
# ---------------------
module "network" {
  source = "git::https://github.com/Hossamgit447/terraform-modules.git//modules/network?ref=master"
  env= var.env
  aws_region = var.aws_region
  vpc_cidr   = var.vpc_cidr
  azs   = var.azs
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
  eks_security_group_ids = module.eks_sg.eks_sg_id
}
module "db_password_secret" {
  source      = "git::https://github.com/Hossamgit447/terraform-modules.git//modules/secret_manger?ref=master"
  name        = var.name
  description = "Secret container for MyApp DB password"
}
data "aws_eks_cluster" "this" {
  name = module.eks.cluster_name
  depends_on = [module.eks] 
}

data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_name
  depends_on = [module.eks] 
}

module "node_group" {
  source = "git::https://github.com/Hossamgit447/terraform-modules.git//modules/eks-nodegroups?ref=master"

  cluster_name  = module.eks.cluster_name
  node_role_arn = module.iam.eks_node_role
  subnet_ids    = module.network.private_subnet_ids

  desired_size = var.node_group_desired_size
  min_size     = var.node_group_min_size
  max_size     = var.node_group_max_size

  instance_types = var.node_group_instance_types
  env            = var.env
  depends_on = [ module.aws_auth ]
}

module "eks_sg" {
  source = "git::https://github.com/Hossamgit447/terraform-modules.git//modules/eks_sg?ref=master"
  env= var.env
}