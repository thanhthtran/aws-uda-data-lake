# Get current AWS account ID
# data "aws_caller_identity" "current" {}
# Glue Policy

data "aws_caller_identity" "current" {}


resource "aws_iam_policy" "glue_policy" {
  name        = var.glue_policy_name
  description = "Policy for AWS Glue job management"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "glue:*Job*",
          "glue:GetDatabase*",
          "glue:GetTable*",
          "glue:GetPartition*",
          "glue:GetConnection*",
          "glue:GetUserDefinedFunction",
          "glue:UpdateDatabase",
          "glue:CreateDatabase",
          "glue:DeleteDatabase",
          "glue:CreateTable",
          "glue:UpdateTable",
          "glue:DeleteTable",
          "glue:GetCatalogImportStatus",
          "glue:GetWorkflow",
          "glue:ListWorkflows",
          "glue:BatchGetWorkflows",
          "glue:GetWorkflowRun",
          "glue:GetWorkflowRuns"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:/aws-glue/*"
      }
    ]
  })
}

# S3 Policy for specific bucket
resource "aws_iam_policy" "s3_policy" {
  name        = var.s3_policy_name
  description = "Policy for specific S3 bucket access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetBucketLocation",
          "s3:*Object*"
        ]
        Resource = "*" # Replace with your bucket name
      }
    ]
  })
}
