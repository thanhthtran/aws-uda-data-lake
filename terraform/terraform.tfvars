# Generic Variables
region      = "us-east-1"
environment = "dev"
owners      = "udacity"

project = "dwh" # Overridning the name defined in variable file


# VPC Variables
cidr            = "10.0.0.0/16"
azs             = ["us-east-1b", "us-east-1c", "us-east-1d"]
public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
# database_subnets                   = ["10.0.151.0/24", "10.0.152.0/24", "10.0.153.0/24"]
# create_database_subnet_group       = true
# create_database_subnet_route_table = true
enable_nat_gateway = true
# single_nat_gateway                 = true

# IAM roles variables
glue_policy_name     = "custom-glue-policy"
s3_policy_name       = "custom-s3-policy"
redshift_policy_name = "custom-redshift-policy"
iam_role_name        = "udacity-warehouse-role"
# S3 bucket
staging_bucket_s3 = "staging_data"

# Redshift cluster
redshift_database_name        = "dwh"
redshift_master_username      = "dwhuser"
redshift_master_user_password = "Passw0rd"
redshift_port_number          = "5439"
redshift_cluster_identifier   = "dwhCluster"
redshift_node_type            = "dc2.large"
redshift_number_of_nodes      = 4
redshift_cluster_type         = "multi-node"
# Create or edit terraform.tfvars
# echo "redshift_cidr = \"$(curl ifconfig.me)/32\"" > terraform.tfvars
# Glue ca
