

provider "aws" {
  region = var.aws_region
}

# Fetch available availability zones in the selected region
data "aws_availability_zones" "available" {}

# Generate a random suffix to ensure unique naming (e.g., for cluster names)
resource "random_string" "suffix" {
  length  = 8
  special = false
}

# Define local values to avoid repeating logic
locals {
  name_prefix  = "paul-eks"
  cluster_name = "${local.name_prefix}-${random_string.suffix.result}"
}

# Create the VPC using a well-maintained Terraform AWS module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.19.0"

  name = "${local.name_prefix}-vpc"
  cidr = var.vpc_cidr

  # Use at least 2 Availability Zones for high availability
  azs             = data.aws_availability_zones.available.names
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.4.0/24", "10.0.5.0/24"]

  # NAT Gateway config - allows private subnets to access the internet
  enable_nat_gateway = true
  single_nat_gateway = true

  # DNS support required for Kubernetes and EC2 resolution
  enable_dns_support   = true
  enable_dns_hostnames = true

  # General tags for resources
  tags = {
    Name        = "${local.name_prefix}-vpc"
    Owner       = "Pauligtech"
    Environment = "dev"
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  # Tag public subnets for use with external load balancers (e.g., ALB/ELB)
  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  # Tag private subnets for use with internal load balancers
  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}
