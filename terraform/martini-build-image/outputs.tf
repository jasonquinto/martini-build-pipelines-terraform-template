output "pipeline_name" {
  description = "Name of the CodePipeline for building Martini Docker images."
  value       = aws_codepipeline.martini_build_pipeline.name
}

output "pipeline_arn" {
  description = "ARN of the CodePipeline."
  value       = aws_codepipeline.martini_build_pipeline.arn
}

output "codebuild_project_name" {
  description = "Name of the CodeBuild project used by this pipeline."
  value       = aws_codebuild_project.martini_build_image.name
}

output "artifact_bucket_name" {
  description = "Name of the S3 artifact bucket used by this pipeline."
  value       = module.s3.artifact_bucket_name
}

output "ecr_repository_url" {
  description = "ECR repository URL where Martini Docker images are pushed."
  value       = module.ecr.ecr_repository_url
}

output "ssm_parameter_name" {
  description = "SSM parameter storing Martini build configuration details."
  value       = module.ssm.ssm_parameter_name
}
