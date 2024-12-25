module "iam_redshift_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 5.48.0"

  create_role       = true
  role_name         = var.iam_role_name
  role_requires_mfa = false

  # Define who can assume this role

  #   trusted_role_arns = [
  #     "arn:aws:iam::${module.iam_policy.assume_role_policy}:root"
  #   ]
  trusted_role_services = [
    "redshift.amazonaws.com",
    "rds.amazonaws.com",
    "glue.amazonaws.com"
  ]
  # Define actions allowed for trusted entities
  trusted_role_actions = [
    "sts:AssumeRole",
    "sts:TagSession"
  ]

  custom_role_policy_arns = [
    aws_iam_policy.glue_policy.arn,
    aws_iam_policy.s3_policy.arn,
    aws_iam_policy.redshift_policy.arn
  ]

  # tags = {
  #   Environment = local.name
  #   Project     = var.project
  # }
}
