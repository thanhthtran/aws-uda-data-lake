output "project" {
  value = var.project
}

# Define an output for the public DNS of the EC2
# instance
# output "bastion_host_dns" {
#   value = module.bastion_host.bastion_host_dns
# }

# # Define an output for the host of the RDS
# output "db_host" {
#   value = module.bastion_host.db_host
# }

# # Define an output for the port of the RDS
# output "db_port" {
#   value = module.bastion_host.db_port
# }

# # Define an output for the username of the RDS
# output "db_master_username" {
#   value = module.bastion_host.db_master_username
# }

# # Define an output for the master password of the RDS
# output "db_master_password" {
#   value     = module.bastion_host.db_master_password
#   sensitive = true
# }


# Outputs ROLE ARN
output "iam_role_arn" {
  description = "The ARN of the IAM Role created for Redshift"
  value       = module.iam_roles.redshift_iam_role_arn
}

output "redshift_endpoint" {
  value = module.redshift_cluster.redshift_endpoint
}

output "redshift_connection_string" {
  value     = module.redshift_cluster.redshift_connection_string
  sensitive = true
}
# output "redshift_endpoint" {
#   value = module.redshift.redshift_endpoint
# }

# output "redshift_cluster_identifier" {
#   value = module.redshift.redshift_cluster_identifier
# }

# output "local_ip_address" {
#   value = local.my_ip
# }


# Write the YAML output to a file
# resource "local_file" "yaml_output" {
#   filename = "${path.module}/output.yml" # Path to the YAML file
#   content  = yamlencode({
#     iam_role_arn =  module.iam_roles.this_iam_role_arn
#     environment  = var.environment
#     project      = var.project
#     services     = [
#       "redshift",
#       "rds",
#       "glue"
#     ]
#   })
# }
