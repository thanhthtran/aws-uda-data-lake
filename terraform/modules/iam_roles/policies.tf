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
      # {
      #   Effect = "Allow"
      #   Action = [
      #     "s3:ListBucket",
      #     "s3:GetBucketLocation"
      #   ]
      #   Resource = [
      #   "arn:aws:s3:::udacity-labs",
      #   "arn:aws:s3:::udacity-labs/*"
      # ]
      # },
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetBucketLocation",
          # "s3:PutObject",
          # "s3:GetObject",
          # "s3:DeleteObject",
          # "s3:PutObjectTagging",
          # "s3:GetObjectTagging",
          # "s3:DeleteObjectTagging",
          # "s3:GetObjectVersion",
          # "s3:GetObjectVersionTagging"
          "s3:*Object*"
        ]
        Resource = "*" # Replace with your bucket name
      }
    ]
  })
}

# Redshift Policy
resource "aws_iam_policy" "redshift_policy" {
  name        = var.redshift_policy_name
  description = "Policy for Redshift cluster management"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "redshift:CreateCluster",
          "redshift:DeleteCluster",
          "redshift:ModifyCluster",
          "redshift:RebootCluster",
          "redshift:CreateClusterSnapshot",
          "redshift:DeleteClusterSnapshot",
          "redshift:CreateClusterParameterGroup",
          "redshift:DeleteClusterParameterGroup",
          "redshift:ModifyClusterParameterGroup",
          "redshift:CreateClusterSecurityGroup",
          "redshift:DeleteClusterSecurityGroup",
          "redshift:ModifyClusterSecurityGroup",
          "redshift:AuthorizeClusterSecurityGroupIngress",
          "redshift:RevokeClusterSecurityGroupIngress",
          "redshift:CreateClusterSubnetGroup",
          "redshift:DeleteClusterSubnetGroup",
          "redshift:ModifyClusterSubnetGroup",
          "redshift:DescribeClusters",
          "redshift:DescribeClusterSnapshots",
          "redshift:DescribeClusterParameterGroups",
          "redshift:DescribeClusterSecurityGroups",
          "redshift:DescribeClusterSubnetGroups"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeVpcs",
          "ec2:DescribeSubnets",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeAvailabilityZones"
        ]
        Resource = "*"
      }
    ]
  })
}


## Redshift CLuster policy back up



# resource "aws_iam_role" "redshift_load" {
#   name = var.redshift_role_name

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Principal = {
#           Service = [
#             "redshift.amazonaws.com",
#             "rds.amazonaws.com",
#             "glue.amazonaws.com",
#           ]
#         }
#         Action = "sts:AssumeRole"
#       }
#     ]
#   })
# }

# data "aws_iam_policy_document" "redshift_load_policy" {
#   statement {
#     effect = "Allow"
#     actions = [
#       "s3:GetBucketLocation",
#       "s3:GetObject",
#       "s3:ListMultipartUploadParts",
#       "s3:ListBucket",
#       "s3:ListBucketMultipartUploads",
#     ]
#     resources = [
#       "arn:aws:s3:::${var.public_bucket_name}",
#       "arn:aws:s3:::${var.public_bucket_name}/*",
#       "arn:aws:s3:::${var.data_lake_bucket_name}",
#       "arn:aws:s3:::${var.data_lake_bucket_name}/*",
#     ]
#   }

#   statement {
#     effect = "Allow"
#     actions = [
#       "glue:CreateDatabase",
#       "glue:DeleteDatabase",
#       "glue:GetDatabase",
#       "glue:GetDatabases",
#       "glue:UpdateDatabase",
#       "glue:CreateTable",
#       "glue:DeleteTable",
#       "glue:BatchDeleteTable",
#       "glue:UpdateTable",
#       "glue:GetTable",
#       "glue:GetTables",
#       "glue:BatchCreatePartition",
#       "glue:CreatePartition",
#       "glue:DeletePartition",
#       "glue:BatchDeletePartition",
#       "glue:UpdatePartition",
#       "glue:GetPartition",
#       "glue:GetPartitions",
#       "glue:BatchGetPartition",
#       "logs:*", # Be cautious about granting overly broad permissions like logs:*
#     ]

#     resources = ["*"]  # Similarly, be cautious about using * for resources
#   }

# }

# resource "aws_iam_role_policy_attachment" "redshift_load_policy_attachment" {
#   role       = aws_iam_role.redshift_load.name
#   policy_arn = data.aws_iam_policy_document.redshift_load_policy.json
# }
