provider "aws" {
  #   version = "~> 2.57.0"
  region = "eu-west-1"
}

locals {
  cluster_name = "ncloud-gblog-proj-cluster"
}

data "terraform_remote_state" "networking" {
  backend = "s3"
  config = {
    bucket = "ncloud-gblog-proj-global-states"
    key    = "networking/terraform.tfstate"
    region = "eu-west-1"
  }
}


module "eks" {
  source          = "git::https://github.com/terraform-aws-modules/terraform-aws-eks.git?ref=v12.1.0"
  cluster_name    = local.cluster_name
  vpc_id          = data.terraform_remote_state.networking.outputs.vpc_id
  subnets         = data.terraform_remote_state.networking.outputs.public_subnets
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
    }
  }

  manage_aws_auth = false
  tags = {
    Environment = "main"
    Name        = "ncloud-gblog-proj"
    Managedby   = "Terraform"
  }
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_endpoint
}