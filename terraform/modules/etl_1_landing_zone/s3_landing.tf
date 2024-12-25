## Create s3 bucket to store data for data lake:
data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "data_lake" {
  bucket_prefix = "${var.project}-${data.aws_caller_identity.current.account_id}-datalake-"
}

resource "aws_s3_bucket_public_access_block" "data_lake" {
  bucket = aws_s3_bucket.data_lake.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "landing_customer" {
  bucket = aws_s3_bucket.data_lake.id
  key    = "/landing/customer/customer-1691348231425.json"
  source = "modules/assets/etl_1_landing_zone/data/customer/landing/customer-1691348231425.json"
  etag   = filemd5("modules/assets/etl_1_landing_zone/data/customer/landing/customer-1691348231425.json")
}


# #Get the list of files in the accelerometer folder

resource "aws_s3_object" "landing_accelerometer" {
  for_each = fileset("modules/assets/etl_1_landing_zone/data/accelerometer/landing", "*.json")
  bucket   = aws_s3_bucket.data_lake.id
  key      = "landing/accelerometer/${each.key}" #This preserves the directory structure on S3

  source = "modules/assets/etl_1_landing_zone/data/accelerometer/landing/${each.key}"
  etag   = filemd5("modules/assets/etl_1_landing_zone/data/accelerometer/landing/${each.key}")
}


resource "aws_s3_object" "landing_step_trainer" {
  for_each = fileset("modules/assets/etl_1_landing_zone/data/step_trainer/landing", "*.json")
  bucket   = aws_s3_bucket.data_lake.id
  key      = "landing/step_trainer/${each.key}" #This preserves the directory structure on S3
  source   = "modules/assets/etl_1_landing_zone/data/step_trainer/landing/${each.key}"
  etag     = filemd5("modules/assets/etl_1_landing_zone/data/step_trainer/landing/${each.key}")
}




