
module "mainvpc" {
  source               = "./module/network"
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  vpc_cidr             = var.vpc_cidr

}

module "security_group" {
  source = "./module/securitygroup"
  vpc_id = module.mainvpc.vpc_id
}

module "load_balancer" {
  source                    = "./module/alb"
  frontend_target_group_arn = module.load_balancer.frontend_target_group_arn
  vpc_id                    = module.mainvpc.vpc_id
  public_subnets_id         = module.mainvpc.public_subnets_id
  private_subnets_id        = module.mainvpc.private_subnets_id
  alb_security_group_id     = [module.security_group.alb_security_group_id]
  ami_id                    = var.ec2_ami
  instance_type             = var.ec2_instance_type
}

module "iam" {
  source = "./module/IAM"
}

module "Fargate" {
  source                   = "./module/fargate"
  eks_cluster_name         = module.eks.eks_cluster_name
  fargate_profile_role     = module.iam.eks_fargate_profile_role
  fargate_execution_policy = module.iam.fargate_execution_policy
  private_subnets_id       = module.mainvpc.private_subnets_id

  depends_on = [module.eks]
}

module "eks" {
  source             = "./module/eks"
  eks_cluster_role   = module.iam.eks_cluster_role
  public_subnets_id  = module.mainvpc.public_subnets_id
  private_subnets_id = module.mainvpc.private_subnets_id
  //eks_cluster_policy = module.iam.eks_cluster_policy

  depends_on = [module.iam]

}


module "node" {
  source                    = "./module/node"
  cluster_name          = module.eks.eks_cluster_name
  node_role_arn             = module.iam.eks_node_role
  WorkerNodePolicy          = module.iam.WorkerNodePolicy
  AmazonEKS_CNI_Policy      = module.iam.AmazonEKS_CNI_Policy
  ContainerRegistryReadOnly = module.iam.ContainerRegistryReadOnly
  public_subnets_id         = module.mainvpc.public_subnets_id
  private_subnets_id        = module.mainvpc.private_subnets_id

  depends_on = [module.Fargate]
}