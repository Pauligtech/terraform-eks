
# EKS Cluster ID
output "cluster_id" {
  description = "EKS Cluster ID."
  value       = module.eks.cluster_id
}

# EKS Cluster Endpoint
output "cluster_endpoint" {
  description = "EKS API server endpoint."
  value       = module.eks.cluster_endpoint
}

# Cluster Security Group ID
output "cluster_security_group_id" {
  description = "Security group ID used by the control plane"
  value       = module.eks.cluster_security_group_id
}

# AWS Region
output "region" {
  description = "AWS region where resources are deployed"
  value       = var.aws_region
}

# OIDC Provider ARN (for IAM roles for service accounts)
output "oidc_provider_arn" {
  description = "ARN of the OIDC provider created for the cluster"
  value       = module.eks.oidc_provider_arn
}

# Uncomment below if you want to output a helpful command to configure kubeconfig
# output "kubeconfig_update_command" {
#   description = "Command to update kubeconfig for this EKS cluster"
#   value       = format("aws eks update-kubeconfig --name %s --region %s", module.eks.cluster_id, var.aws_region)
# }
