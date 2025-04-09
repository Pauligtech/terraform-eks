
# -----------------------------------------------
# SECURITY GROUP for EKS Worker Node Management
# Allows internal traffic between worker nodes
# and outbound internet access.
# -----------------------------------------------

module "all_worker_mgmt_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  name        = "all-worker-mgmt"
  description = "Security group to allow EKS worker nodes communication and internet access"
  vpc_id      = module.vpc.vpc_id

  # Allow all traffic internally within private CIDRs
  ingress_rules        = ["all-all"]
  ingress_cidr_blocks  = [
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16"
  ]

  # Allow all outbound traffic
  egress_rules         = ["all-all"]

  tags = {
    Name    = "all-worker-mgmt"
    Owner   = "Pauligtech"  # Optional: update with your name for easier identification
    Purpose = "EKS Worker Node Management"
  }
}
