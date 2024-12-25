terraform {
  required_providers {
    redshift = {
      source  = "brainly/redshift"
      version = ">= 0.2.4"
    }
  }
}

# provider "redshift" {
#   alias    = "default"
#   # host     = var.redshift_host
#   username = var.redshift_master_username
#   password = var.redshift_master_user_password
#   database = var.redshift_database_name
#   port     = var.redshift_port_number
# }
