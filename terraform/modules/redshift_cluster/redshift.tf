
# resource "aws_security_group" "redshift" {
#   name        = "${var.project}-redshift-sg"
#   description = "Security group for Redshift cluster"
#   vpc_id      = aws_vpc.main.id

#   ingress {
#     from_port   = var.redshift_port_number
#     to_port     = var.redshift_port_number
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"] # WARNING: Open to the world.  Restrict in production!
#   }
# }

resource "aws_security_group" "redshift" {
  name        = "redshift-sg"
  description = "Security group for Redshift cluster"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.redshift_port_number
    to_port     = var.redshift_port_number
    protocol    = "tcp"
    cidr_blocks = [var.redshift_cidr] # Replace with your local IP address
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_redshift_subnet_group" "redshift_subnet" {
  name        = "${var.project}-redshift-subnet-group"
  description = "Subnet group for Redshift cluster"
  subnet_ids = [
    var.vpc_public_subnet_ids[0],
    var.vpc_public_subnet_ids[1]
  ]
}



resource "aws_redshift_cluster" "redshift_cluster" {
  cluster_identifier = "${var.project}-redshift-cluster"
  cluster_type       = var.redshift_cluster_type # Single node for testing purposes
  node_type          = var.redshift_node_type    # Consider using a more appropriate node type
  number_of_nodes    = var.redshift_number_of_nodes
  database_name      = var.redshift_database_name
  master_username    = var.redshift_master_username
  master_password    = var.redshift_master_user_password
  # cluster_parameter_group_name = "default" # Or a custom parameter group
  vpc_security_group_ids    = [aws_security_group.redshift.id]
  cluster_subnet_group_name = aws_redshift_subnet_group.redshift_subnet.name
  # availability_zone_relocation_enabled  = True
  #availability_zone = ...
  publicly_accessible = true # WARNING:  Set to false in production for security
  port                = var.redshift_port_number

  # IAM roles - requires additional configuration depending on your needs.
  # iam_roles = [aws_iam_role.my_redshift_iam_role.arn]
  iam_roles = [var.redshift_iam_role_arn]

}
