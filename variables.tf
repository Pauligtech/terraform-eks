
# Kubernetes Version to deploy (used in the EKS cluster module)
variable "kubernetes_version" {
  type        = string
  default     = "1.27"
  description = "Kubernetes version for the EKS cluster"
}

# AWS Region
variable "aws_region" {
  type        = string
  default     = "us-west-1"
  description = "AWS region where resources will be deployed"
}

# CIDR block for VPC
variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR range of the VPC"
}

# Tags (Optional - helpful for cost tracking and filtering in AWS console)
variable "common_tags" {
  type        = map(string)
  default     = {
    Owner   = "Pauligtech"
    Project = "EKS-Cluster"
  }
  description = "Common tags applied to all resources"
}
