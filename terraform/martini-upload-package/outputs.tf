output "pipeline_name" {
  description = "Name of the CodePipeline for uploading Martini packages."
  value       = aws_codepipeline.martini_upload_pipeline.name
}

output "pipeline_arn" {
  description = "ARN of the CodePipeline."
  value       = aws_codepipeline.martini_upload_pipeline.arn
}

output "codebuild_project_name" {
  description = "Name of the CodeBuild project used by this pipeline."
  value       = aws_codebuild_project.martini_upload_package.name
}

output "artifact_bucket_name" {
  description = "Name of the S3 artifact bucket used by this pipeline."
  value       = module.s3.artifact_bucket_name
}

output "ssm_parameter_name" {
  description = "SSM parameter storing Martini upload configuration."
  value       = module.ssm.ssm_parameter_name
}
