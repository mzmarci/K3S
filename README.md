# K3S

# EKS

This module provisions an Amazon Elastic Kubernetes Service (EKS) cluster along with its necessary IAM roles, Fargate profile, and node group using Terraform.

---

## Module Structure

- `module/iam` - Creates IAM roles and policy attachments required by the EKS cluster, node group, and Fargate.
- `module/eks` - Provisions the EKS control plane.
- `module/node` - Provisions the managed node group for EKS.
- `module/fargate` - Provisions a Fargate profile for running pods.

## Requirements
Terraform v1.3+

AWS CLI configured

IAM permissions to provision EKS, IAM roles, and networking


## How to Apply

- terraform init
- terraform plan
- terraform apply


##  Notes
- Make sure subnets are tagged with kubernetes.io/cluster/<cluster-name> = owned.

- Ensure your VPC and networking modules are correctly configured before applying this module.

- Fargate will only run pods from the namespaces defined in the selectors.

