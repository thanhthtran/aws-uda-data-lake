# Outputs
output "assume_role_policy" {
  description = "assume role for this policy"
  value       = data.aws_caller_identity.current.account_id
}
output "glue_policy" {
  description = "ARN of the created Glue role"
  value       = aws_iam_policy.glue_policy.arn
}

output "s3_policy" {
  description = "ARN of the created S3 role"
  value       = aws_iam_policy.s3_policy.arn
}
output "redshift_policy" {
  description = "ARN of the created Redshift role"
  value       = aws_iam_policy.redshift_policy.arn
}

output "redshift_iam_role_arn"{
  description = "ARN of the created Redshift role"
  value       = module.iam_redshift_role.iam_role_arn
}
