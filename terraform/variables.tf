# Include the definition of the variables you will use throughout the
# definition of resources.
# AWS Region
variable "region" {
  type        = string
  description = "The AWS region to use for provisioning"
}
# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type        = string
}

variable "project" {
  type        = string
  description = "The name of the project"
}
# Business Division
variable "owners" {
  description = "organization this Infrastructure belongs"
  type        = string
}

# VPC variables defined as below

# VPC CIDR Block
variable "cidr" {
  description = "VPC CIDR Block"
  type        = string
  default     = "10.0.0.0/16"
}

# VPC Availability Zones
variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = ["eu-west-2a", "eu-west-2b"]
}

# VPC Public Subnets
variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

# VPC Private Subnets
variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

# VPC Database Subnets
variable "database_subnets" {
  description = "A list of database subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.151.0/24", "10.0.152.0/24"]
}

# VPC Create Database Subnet Group (True / False)
variable "create_database_subnet_group" {
  description = "VPC Create Database Subnet Group, Controls if database subnet group should be created"
  type        = bool
  default     = true
}

# VPC Create Database Subnet Route Table (True or False)
variable "create_database_subnet_route_table" {
  description = "VPC Create Database Subnet Route Table, Controls if separate route table for database should be created"
  type        = bool
  default     = true
}


# VPC Enable NAT Gateway (True or False) 
variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  type        = bool
  default     = true
}

# VPC Single NAT Gateway (True or False)
variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type        = bool
  default     = true
}

## IAM polices variable
variable "glue_policy_name" {
  description = "Name for glue custom role"
  type        = string
}
variable "s3_policy_name" {
  description = "ARN of the created S3 role"
  type        = string
}
variable "redshift_policy_name" {
  description = "ARN of the created Redshift role"
  type        = string
}

# IAM roles:
variable "iam_role_name" {
  description = "Name for IAM role"
  type        = string
}



# S3 variable
variable "staging_bucket_s3" {
  description = "Staging s3 bucket  name"
  type        = string
  default     = "staging"
}

### RDS Variables ###
# variable "db_master_username" {
#   type        = string
#   description = "The master username for the RDS instance"
#   default     = "postgres_admin"
# }





variable "redshift_database_name" {
  type    = string
  default = "dev"
}

variable "redshift_master_username" {
  type    = string
  default = "defaultuser"
}

variable "redshift_master_user_password" {
  type      = string
  sensitive = true
  default   = "Defaultuserpwrd1234+"
}

variable "redshift_port_number" {
  type    = number
  default = 5439
}
variable "redshift_cluster_identifier" {
  type = string
}

variable "redshift_node_type" {
  type = string
}
variable "redshift_cluster_type" {
  type = string
}

variable "redshift_number_of_nodes" {
  type = string
}

variable "redshift_cidr" {
  type = string
}

# vari
