# Define the versions and configurations of the providers

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.39.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.4.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "= 3.6.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.5"
    }
  }
}
# data "aws_secretsmanager_secret" "my_secret" {
#   name = "my_secret_name"
# }

# data "aws_secretsmanager_secret_version" "my_secret_version" {
#   secret_id = data.aws_secretsmanager_secret.my_secret.id
# }


# Add to the provider configuration the tags and
# parameters needed
provider "aws" {
  region = var.region
  # access_key = jsondecode(data.aws_secretsmanager_secret_version.my_secret_version.secret_string)["AWS_ACCESS_KEY_ID"]
  # secret_key = jsondecode(data.aws_secretsmanager_secret_version.my_secret_version.secret_string)["AWS_SECRET_ACCESS_KEY"]

  default_tags {
    tags = {
      comments  = "this resource is managed by terraform"
      terraform = "true"
      project   = var.project
    }
  }
}
