# K3S


##  K3S Cluster Provisioning on AWS & Azure

This project provisions lightweight Kubernetes (K3s) clusters across AWS and Azure, using Terraform to automate infrastructure provisioning.

It supports:

- Amazon EKS (Elastic Kubernetes Service) with managed node groups and Fargate

- Azure AKS

## Module Overview
## AWS - Amazon EKS Cluster Setup
This part of the module automates the provisioning of an Amazon EKS Cluster along with essential IAM roles, networking, and compute resources.

## AWS Module Structure:

- module/iam – Provisions IAM roles and policies for EKS, node groups, and Fargate profiles.

- module/eks – Deploys the EKS control plane.

- module/node – Creates managed node groups.

- module/fargate – Sets up a Fargate profile to run pods serverlessly.

##  Requirements for AWS
- Terraform v1.3+

- AWS CLI configured

- IAM permissions to create EKS, networking, and IAM resources

##  How to Deploy (AWS)

- terraform init
- terraform plan
- terraform apply

## Notes for AWS
- Tag your subnets with kubernetes.io/cluster/<cluster-name> = owned.

- Ensure the VPC and subnets exist before applying the EKS module.

- Fargate only schedules pods from namespaces defined in the selector block.


## Azure - Azure Kubernetes Service (AKS) Setup
This section of the module provisions a fully managed Kubernetes cluster (AKS) on Microsoft Azure using Terraform. It mirrors the AWS EKS setup by automating the creation of secure, scalable Kubernetes environments using native Azure services.

## What This Setup Includes
- Azure Resource Group

- Virtual Network (VNet) and Subnets for AKS

- Network Security Groups (NSGs) for AKS traffic control

- Azure Kubernetes Service (AKS) cluster provisioning

- Optional Azure Storage resources

- Outputs for AKS cluster name, node resource group, and kubeconfig access

- This setup is ideal for running containerized applications in production, with native support for monitoring, auto-scaling, and secure networking.

##  Prerequisites
To deploy the AKS cluster, ensure the following are set up:

- Terraform v1.3+

- Azure CLI

- Azure subscription with contributor or owner permissions

- (Optional) kubectl installed locally for managing the cluster

##  Azure Module Structure
- module/vent – Provisions the Virtual Network and Subnets

- module/security – Configures Network Security Groups (NSGs)

- module/storage – Optional module to provision storage resources (e.g., Azure Disks/File Share)

- module/eks –  Provisions the AKS cluster



## How to Deploy (Azure)

- cd azure
- terraform init
- terraform plan
- terraform apply
- Once deployed, retrieve your AKS credentials to access the cluster:

## Key Features
- Fully managed Azure Kubernetes Service

- Integrated with Azure networking, security, and monitoring

- Terraform-based deployment with modular design

- Easily customizable for staging, dev, or production environments

##  Security Tips
- Use Azure AD integration for secure AKS access

- Enable role-based access control (RBAC) and pod identity

- Ensure NSG rules only expose necessary ports (e.g., 443 for API server)

- Rotate cluster credentials periodically and store them securely

 ## Contributing
If you’d like to improve the module, feel free to fork the repo and submit a pull request. Feedback, issues, and feature requests are welcome!

