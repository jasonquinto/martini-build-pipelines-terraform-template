output "codebuild_role_name" {
  description = "Name of the IAM role for CodeBuild."
  value       = aws_iam_role.martini_codebuild_role.name
}

output "codebuild_role_arn" {
  description = "ARN of the IAM role for CodeBuild."
  value       = aws_iam_role.martini_codebuild_role.arn
}
