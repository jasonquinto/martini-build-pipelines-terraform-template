locals {
  default_tags = {
    Service = "S3"
  }
}

# Artifact Bucket
resource "aws_s3_bucket" "martini_artifacts" {
  bucket = var.bucket_name
  tags   = merge(local.default_tags, var.tags)
}

# Enable Versioning
resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.martini_artifacts.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Optional Encryption (KMS or AES256)
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.martini_artifacts.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = var.kms_key_arn != null ? "aws:kms" : "AES256"
      kms_master_key_id = var.kms_key_arn
    }
  }
}
