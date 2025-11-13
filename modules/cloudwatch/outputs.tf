output "project_log_group_name" {
  description = "The name of the CodeBuild (project) CloudWatch log group."
  value       = aws_cloudwatch_log_group.martini_project_logs.name
}

output "project_log_group_arn" {
  description = "The ARN of the CodeBuild (project) CloudWatch log group."
  value       = aws_cloudwatch_log_group.martini_project_logs.arn
}

output "pipeline_log_group_name" {
  description = "The name of the CodePipeline CloudWatch log group."
  value       = aws_cloudwatch_log_group.martini_pipeline_logs.name
}

output "pipeline_log_group_arn" {
  description = "The ARN of the CodePipeline CloudWatch log group."
  value       = aws_cloudwatch_log_group.martini_pipeline_logs.arn
}
