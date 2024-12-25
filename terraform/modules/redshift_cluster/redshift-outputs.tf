output "redshift_endpoint" {
  value = aws_redshift_cluster.redshift_cluster.endpoint
}

output "redshift_cluster_identifier" {
  value = aws_redshift_cluster.redshift_cluster.cluster_identifier
}


output "redshift_connection_string" {
  description = "The connection string for the Redshift cluster"
  value = format(
    "postgresql://%s:%s@%s:%d/%s",
    var.redshift_master_username,                   # DWH_DB_USER
    var.redshift_master_user_password,              # DWH_DB_PASSWORD
    aws_redshift_cluster.redshift_cluster.endpoint, # DWH_ENDPOINT
    var.redshift_port_number,                       # DWH_PORT
    var.redshift_database_name                      # DWH_DB
  )
  sensitive = true
}
