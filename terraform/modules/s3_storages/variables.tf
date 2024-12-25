variable "staging_bucket_s3" {
  description = "Staging s3 bucket  name"
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "region" {
  type        = string
  description = "The AWS region to use for provisioning"
}
