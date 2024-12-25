variable "glue_policy_name" {
  description = "ARN of the created Glue role"
  type        = string
}

variable "s3_policy_name" {
  description = "ARN of the created S3 role"
  type        = string
}
variable "redshift_policy_name" {
  description = "ARN of the created Redshift role"
  type        = string
}

variable "iam_role_name" {
  description = "Name for IAM role"
  type        = string
}

