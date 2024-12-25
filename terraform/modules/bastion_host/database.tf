resource "random_id" "master_password" {
  byte_length = 8
}

# Create a db subnet group using the private
# subnets of AZ A and B
resource "aws_db_subnet_group" "database" {
  name       = "${var.project}-db-subnet-group"
  subnet_ids = [var.private_subnet_a_id, var.private_subnet_b_id]
}

# Complete the configuration for the RDS instance
resource "aws_db_instance" "database" {
  identifier             = "${var.project}-db"
  instance_class         = "db.t3.micro" # Use the db.t3.micro instance type
  allocated_storage      = 20
  storage_type           = "gp2"
  db_subnet_group_name   = aws_db_subnet_group.database.name # Use the db subnet group you created above
  vpc_security_group_ids = [var.database_sg_id]              # Use the security group you created for the RDS in network.tf

  engine         = "postgres"
  engine_version = "15"

  port     = 5432
  db_name  = "postgres"
  username = var.db_master_username       # Use the master username variable
  password = random_id.master_password.id # Use the master password generated above

  publicly_accessible = false
  skip_final_snapshot = true
  tags = {
    Name = "RedShift-PostGres-RDS"
  }
}


# DynamoDB Table for State Locking
resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "${var.project}-terraform-state-lock"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
