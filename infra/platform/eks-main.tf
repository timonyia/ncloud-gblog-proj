provider "aws" {
  #   version = "~> 2.57.0"
  region = "eu-west-1"
}

locals {
  cluster_name = "ncloud-gblog-proj-cluster"
}

module "eks" {
  source          = "git::https://github.com/terraform-aws-modules/terraform-aws-eks.git?ref=v12.1.0"
  cluster_name    = local.cluster_name
  vpc_id          = "vpc-019c5972a170d9f60"
  subnets         = ["subnet-0795dc4e326f91af2", "subnet-0efcbf98dd32ace43", "subnet-0864bbe4387a46668"]
  cluster_version = "1.20"

  node_groups = {
    eks_nodes = {
      desired_capacity = 3
      max_capacity     = 4
      min_capaicty     = 1
      instance_type    = "t2.small"

      k8s_labels = {
        Environment = "ncloud-gblog-proj-cluster"
      }

      # tags = {
      #   Name = "ncloud-gblog-proj"
      # }
    }
  }

  manage_aws_auth = false
  # map_users    = var.map_users
#   map_accounts = var.map_accounts
  # write_kubeconfig = false 

  tags = {
    Environment = "ncloud-gblog-projCluster"
    Name = "ncloud-gblog-proj"
    Managedby = "Terraform"
  }
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_endpoint
}