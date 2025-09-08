# ---------------------
# Network Module
# ---------------------
module "network" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b"]
  private_subnets = ["10.0.101.0/24","10.0.102.0/24"]
  public_subnets  = ["10.0.1.0/24",  "10.0.2.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
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
  eks_security_group_ids = [module.eks_sg.eks_sg_id]
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
}

module "eks_sg" {
  source = "git::https://github.com/Hossamgit447/terraform-modules.git//modules/eks_sg?ref=master"
  env= var.env
  vpc_id=module.network.vpc_id
}


module "nat" {
  source = "git::https://github.com/Hossamgit447/terraform-modules.git//modules/eks_sg?ref=master"

  env                = var.env
  vpc_id             = module.network.vpc_id
  public_subnet_id   = module.network.public_subnet_ids # pick first public subnet
  private_subnet_ids = module.network.private_subnet_ids
}
