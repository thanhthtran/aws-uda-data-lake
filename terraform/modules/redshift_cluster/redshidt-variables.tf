variable "project" {
  type        = string
  description = "The name of the project. This is used to prefix resources for easy identification."
}

variable "redshift_database_name" {
  type        = string
  description = "The name of the Redshift database to be created within the cluster."
}

variable "redshift_master_username" {
  type        = string
  description = "The master username for the Redshift cluster. This user will have administrative privileges on the database."
}

variable "redshift_master_user_password" {
  type        = string
  sensitive   = true
  description = "The master password for the Redshift cluster. This is sensitive and should be stored securely."
}

variable "redshift_port_number" {
  type        = number
  description = "The port number on which the Redshift cluster will accept connections. Default is 5439."
}

variable "redshift_cluster_identifier" {
  type        = string
  description = "A unique identifier for the Redshift cluster. This is used to name the cluster."
}

variable "redshift_node_type" {
  type        = string
  description = "The type of nodes to be used in the Redshift cluster (e.g., dc2.large, ra3.xlplus)."
}

variable "redshift_cluster_type" {
  type        = string
  description = "The type of Redshift cluster to create. Options include 'single-node' or 'multi-node'."
}

variable "redshift_number_of_nodes" {
  type        = string
  description = "The number of compute nodes in the Redshift cluster. For 'single-node' clusters, this should be 1."
}

variable "redshift_iam_role_arn" {
  type        = string
  description = "The ARN of the IAM role that the Redshift cluster will assume to access other AWS services (e.g., S3)."
}

variable "redshift_cidr" {
  type        = string
  description = "The CIDR block to allow inbound traffic to the Redshift cluster. For example, '0.0.0.0/0' allows access from anywhere (not recommended for production)."
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where the Redshift cluster will be deployed."
}

variable "vpc_public_subnet_ids" {
  type        = list(string)
  description = "A list of public subnet IDs within the VPC where the Redshift cluster will be deployed."
}

# Uncomment and use these variables if needed for S3 bucket configurations
# variable "public_bucket_name" {
#   type        = string
#   description = "The name of your public S3 bucket. This bucket can be used for storing publicly accessible data."
# }

# variable "data_lake_bucket_name" {
#   type        = string
#   description = "The name of your data lake S3 bucket. This bucket is used for storing raw or processed data in a data lake architecture."
# }
