# Local Values in Terraform
locals {
  owners      = var.owners
  environment = var.environment
  # my_ip       = "${chomp(data.http.my_ip.body)}/32"
  name        = "${local.owners}-${local.environment}"
  tags = {
    owners      = local.owners
    environment = local.environment
  }
}
