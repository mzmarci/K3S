resource "aws_eks_node_group" "eks_demo_node_group" {
cluster_name           = var.cluster_name
node_role_arn   = var.node_role_arn
node_group_name = "eks_node_group"
subnet_ids = concat(var.private_subnets_id, var.public_subnets_id)
scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 1
}
update_config {
    max_unavailable = 1
}

# Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
# Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
depends_on = [
    var.WorkerNodePolicy,
    var.AmazonEKS_CNI_Policy,
    var.ContainerRegistryReadOnly,
]
}