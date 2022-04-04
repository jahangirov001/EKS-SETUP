###############################################
#               Account variables             #
###############################################
environment = "DEV"
name        = "Trello"
product     = "LAB"
email       = "example@example.com"
region      = "us-west-2"

###############################################
#            Cluster variables                #
###############################################
cluster_name                    = "trello-1"
cluster_version                 = "1.22"
cluster_endpoint_private_access = true
cluster_endpoint_public_access  = true

###############################################
#            Node group variables             #
###############################################
node_group_ami_type       = "AL2_x86_64"
node_group_disk_size      = "200"
node_group_instance_types = ["m5.large", "m5.2xlarge"]
node_group_capacity_type  = "ON_DEMAND"
node_group_min_size       = "1"
node_group_max_size       = "10"
node_group_desired_size   = "1"

###############################################
#               VPC variables                 #
###############################################
vpc_name = "YOUR VPC NAME"
