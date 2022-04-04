################################################################################
#                                  EKS Module                                  #
################################################################################
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.18.0"

  cluster_name                    = var.cluster_name
  cluster_version                 = var.cluster_version
  cluster_endpoint_private_access = var.cluster_endpoint_private_access
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access

  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  vpc_id     = data.aws_vpc.vpc.id
  subnet_ids = data.aws_subnets.private.ids

  eks_managed_node_group_defaults = {
    ami_type       = var.node_group_ami_type
    disk_size      = var.node_group_disk_size
    instance_types = var.node_group_instance_types
    capacity_type  = var.node_group_capacity_type
  }

  eks_managed_node_groups = {
    trello-ng-1 = {
      use_name_prefix = false
      min_size        = var.node_group_min_size
      max_size        = var.node_group_max_size
      desired_size    = var.node_group_desired_size

      instance_types = var.node_group_instance_types
      capacity_type  = var.node_group_capacity_type
      labels = {
        Environment = "dev"
      }

      pre_bootstrap_user_data = <<-EOT
      #!/usr/bin/env bash
      set -e
      # install AWS SSM Agent
      yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
      EOT

      iam_role_additional_policies = [
        "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
      ]
      tags = {
        Name        = "trello-ng-1"
        Environment = "dev"
      }
      additional_tags = {
        Name = "trello-ng-1"
      }
    }
  }
}

module "irsa" {
  source = "Young-ook/eks/aws//modules/iam-role-for-serviceaccount"

  namespace      = "default"
  serviceaccount = "iam-trello"
  oidc_url       = module.eks.oidc_provider
  oidc_arn       = module.eks.oidc_provider_arn
  policy_arns    = ["arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]
  name           = "irsa-s3-readonly"
  tags = {
    Name        = "ReadOnly"
    Environment = "DEV"
  }
}