resource "aws_s3_bucket" "staging_state" {
  bucket_prefix = "${var.project}-${var.staging_bucket_s3}"
}

resource "aws_s3_bucket_public_access_block" "staging_state" {
  bucket = aws_s3_bucket.staging_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "terraform_state" {
  bucket_prefix = "${var.project}-${var.region}-terraform-state"
}

resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}



# resource "aws_s3_object" "glue_job_reviews_script" {
#   bucket = aws_s3_bucket.scripts.id
#   key    = "de-c3w2-reviews-transform-job.py"
#   source = "./assets/de-c3w2-reviews-transform-job.py"

#   etag = filemd5("./assets/de-c3w2-reviews-transform-job.py")
# }


# resource "aws_s3_object" "glue_job_metadata_script" {
#   bucket = aws_s3_bucket.scripts.id
#   key    = "de-c3w2-metadata-transform-job.py"
#   source = "./assets/de-c3w2-metadata-transform-job.py"

#   etag = filemd5("./assets/de-c3w2-metadata-transform-job.py")
# }
