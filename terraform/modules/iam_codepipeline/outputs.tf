output "codepipeline_role_name" {
  description = "Name of the IAM role created for CodePipeline."
  value       = aws_iam_role.martini_codepipeline_role.name
}

output "codepipeline_role_arn" {
  description = "ARN of the IAM role created for CodePipeline."
  value       = aws_iam_role.martini_codepipeline_role.arn
}
