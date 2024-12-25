# Output Block to expose s3 bucket name
output "s3_bucket_name" {
  value       = aws_s3_bucket.data_lake.bucket
  description = "Name of the S3 bucket created for the data lake"
}
