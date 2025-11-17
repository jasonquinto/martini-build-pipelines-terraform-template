output "ssm_parameter_name" {
  description = "The full name of the SSM parameter."
  value       = aws_ssm_parameter.martini_ssm_parameter.name
}

output "ssm_parameter_arn" {
  description = "The ARN of the SSM parameter."
  value       = aws_ssm_parameter.martini_ssm_parameter.arn
}
