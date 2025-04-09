
# Create an EKS cluster using the latest AWS EKS module
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.35.0"  # Latest as of April 2025

  # Basic cluster settings
  cluster_name    = local.cluster_name
  cluster_version = var.kubernetes_version

  # VPC configuration
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # Enable IAM Roles for Service Accounts (IRSA)
  enable_irsa = true

  # Tagging resources for management and cost allocation
  tags = {
    Name    = "eks-cluster"
    Owner   = "Pauligtech"
    Project = "demo"
  }

  # Default settings for all managed node groups
  eks_managed_node_group_defaults = {
    ami_type               = "AL2_x86_64"               # Amazon Linux 2
    instance_types         = ["t3.medium"]              # EC2 instance type
    vpc_security_group_ids = [aws_security_group.all_worker_mgmt.id]  # Custom SG
  }

  # Define node group(s)
  eks_managed_node_groups = {
    default = {
      name         = "node-group"
      desired_size = 2
      min_size     = 2
      max_size     = 6
    }
  }
}
