output "artifact_bucket_name" {
  description = "Name of the S3 artifact bucket."
  value       = aws_s3_bucket.martini_artifacts.bucket
}

output "artifact_bucket_arn" {
  description = "ARN of the S3 artifact bucket."
  value       = aws_s3_bucket.martini_artifacts.arn
}

output "artifact_bucket_region" {
  description = "AWS region where the S3 artifact bucket resides."
  value       = aws_s3_bucket.martini_artifacts.region
}
