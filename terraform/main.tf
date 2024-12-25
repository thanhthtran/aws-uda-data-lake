# module "custom_vpc" {
#   source        = "./modules/vpc"
#   project       = var.project
#   region        = var.region
#   zone1         = var.zone1
#   zone2         = var.zone2
#   cidr_all      = var.cidr_all
#   cidr_main_vpc = var.cidr_main_vpc
#   cidr_pub1     = var.cidr_pub1
#   cidr_pub2     = var.cidr_pub2
#   cidr_private1 = var.cidr_private1
#   cidr_private2 = var.cidr_private2

# }
# Create VPC using Terraform Module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  # Details
  name            = "${var.project}-${local.name}-vpc"
  cidr            = var.cidr
  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  # database_subnets                   = var.database_subnets
  # create_database_subnet_group       = var.create_database_subnet_group
  # create_database_subnet_route_table = var.create_database_subnet_route_table
  # create_database_internet_gateway_route = true
  # create_database_nat_gateway_route = true

  # NAT Gateways - Outbound Communication
  enable_nat_gateway = var.enable_nat_gateway
  # single_nat_gateway = var.single_nat_gateway

  # DNS Parameters in VPC
  enable_dns_hostnames = true
  enable_dns_support   = true

  # Additional tags for the VPC
  tags     = local.tags
  vpc_tags = local.tags

  # Additional tags
  # Additional tags for the public subnets
  public_subnet_tags = {
    Name = "VPC Public Subnets"
  }
  # Additional tags for the private subnets
  private_subnet_tags = {
    Name = "VPC Private Subnets"
  }
  # Additional tags for the database subnets
  # database_subnet_tags = {
  #   Name = "VPC Private Database Subnets"
  # }
  # Instances launched into the Public subnet should be assigned a public IP address. Specify true to indicate that instances launched into the subnet should be assigned a public IP address
  map_public_ip_on_launch = true
}

module "iam_roles" {
  source               = "./modules/iam_roles"
  glue_policy_name     = var.glue_policy_name
  s3_policy_name       = var.s3_policy_name
  redshift_policy_name = var.redshift_policy_name
  iam_role_name        = var.iam_role_name


}



module "redshift_cluster" {
  source                        = "./modules/redshift_cluster"
  project                       = var.project
  vpc_id                        = module.vpc.vpc_id
  vpc_public_subnet_ids         = module.vpc.public_subnets
  redshift_database_name        = var.redshift_database_name
  redshift_master_username      = var.redshift_master_username
  redshift_master_user_password = var.redshift_master_user_password
  redshift_port_number          = var.redshift_port_number
  redshift_cluster_identifier   = var.redshift_cluster_identifier
  redshift_node_type            = var.redshift_node_type
  redshift_cluster_type         = var.redshift_cluster_type
  redshift_number_of_nodes      = var.redshift_number_of_nodes
  redshift_iam_role_arn         = module.iam_roles.redshift_iam_role_arn
  redshift_cidr                 = var.redshift_cidr
}

# module "s3" {
#   source            = "./modules/s3_storages"
#   project           = var.project
#   region            = var.region
#   staging_bucket_s3 = var.staging_bucket_s3
# }


# module "bastion_host" {
#   source              = "./modules/bastion_host"
#   project             = var.project
#   region              = var.region
#   vpc_id              = module.vpc.vpc_id
#   public_subnet_a_id  = module.vpc.public_subnet_a_id
#   public_subnet_b_id  = module.vpc.public_subnet_b_id
#   private_subnet_a_id = module.vpc.private_subnet_a_id
#   private_subnet_b_id = module.vpc.private_subnet_b_id
#   bastion_host_sg_id  = module.vpc.bastion_host_sg_id
#   database_sg_id      = module.vpc.database_sg_id
#   db_master_username  = var.db_master_username
# }
