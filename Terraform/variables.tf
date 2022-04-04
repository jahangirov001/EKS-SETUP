################################################################################
#                                  Common                                      #
################################################################################
variable "region" {
  description = "AWS region"
  type        = string
}

variable "environment" {
  description = "Environment name (test, prod)"
}

variable "product" {
  description = "Product Name"
}

variable "email" {
  description = "AWS root account email"
}

variable "name" {
  description = "Team name"
}
################################################################################
#                           EKS cluster variables                              #
################################################################################

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = ""
}

variable "cluster_version" {
  description = "Kubernetes `<major>.<minor>` version to use for the EKS cluster (i.e.: `1.21`)"
  type        = string
  default     = null
}

variable "cluster_endpoint_private_access" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled"
  type        = bool
  default     = false
}

variable "cluster_endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled"
  type        = bool
  default     = true
}

variable "use_name_prefix" {
  description = "Determines whether to use `name` as is or create a unique name beginning with the `name` as the prefix"
  type        = bool
  default     = false
}

variable "node_group_ami_type" {
  description = "Type of Amazon Machine Image (AMI) associated with the EKS Node Group. Valid values are `AL2_x86_64`, `AL2_x86_64_GPU`, `AL2_ARM_64`, `CUSTOM`, `BOTTLEROCKET_ARM_64`, `BOTTLEROCKET_x86_64`"
  type        = string
  default     = null
}

variable "node_group_disk_size" {
  description = "Indicates the root device disk size (in GiB) for node group instances"
  type        = string
  default     = null
}

variable "node_group_instance_types" {
  description = "Indicates the instance types for a node group"
  type        = list(string)
  default     = []
}

variable "node_group_capacity_type" {
  description = "Indicates the capacity type of managed node group."
  type        = string
  default     = ""
}

variable "node_group_min_size" {
  description = "The minimum number of nodes that the managed node group can scale in to"
  type        = string
  default     = null
}

variable "node_group_max_size" {
  description = "The maximum number of nodes that the managed node group can scale out to"
  type        = string
  default     = null
}

variable "node_group_desired_size" {
  description = "The current number of nodes that the managed node group should maintain"
  type        = string
  default     = null
}