resource "aws_eks_cluster" "eks_cluster" {
    name = var.cluster_name
    role_arn = var.eks_cluster_role
    vpc_config {
    endpoint_private_access = true  //this means that my worker node will join the cluster interally within the vpc andthey wont get routed out of the vpc
    endpoint_public_access = true  //this means that i want my cluster to be accessed outside the vpc
    subnet_ids = concat(var.private_subnets_id, var.public_subnets_id)  # Use concat() to combine both the public and the private subnet into a single list
  
    }
    access_config {
    authentication_mode = "API"
    bootstrap_cluster_creator_admin_permissions = true
    }
    bootstrap_self_managed_addons = true
    tags = var.tags
    version = var.eks_version
    upgrade_policy {
    support_type = "STANDARD"
    }
    //depends_on = var.eks_cluster_policy
}