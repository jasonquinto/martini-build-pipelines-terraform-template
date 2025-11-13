output "ecr_repository_name" {
  description = "Name of the ECR repository."
  value       = aws_ecr_repository.martini_ecr_repository.name
}

output "ecr_repository_arn" {
  description = "ARN of the ECR repository."
  value       = aws_ecr_repository.martini_ecr_repository.arn
}

output "ecr_repository_url" {
  description = "URL of the ECR repository (registry/repo path)."
  value       = aws_ecr_repository.martini_ecr_repository.repository_url
}
