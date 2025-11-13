variable "role_name" {
  description = "Name of the IAM role for CodePipeline (e.g., martini-codepipeline-role-dev)."
  type        = string
}

variable "policy_name" {
  description = "Name of the inline policy attached to the CodePipeline role."
  type        = string
  default     = "martini-codepipeline-policy"
}

variable "artifact_bucket_arn" {
  description = "ARN of the S3 artifact bucket used by the pipeline."
  type        = string
}

variable "codebuild_role_arn" {
  description = "ARN of the IAM role used by CodeBuild. Required for PassRole."
  type        = string
}

variable "codestar_connection_arn" {
  description = "ARN of the CodeStar Connection used by CodePipeline to connect to GitHub."
  type        = string
}

variable "kms_key_arns" {
  description = "Optional list of KMS key ARNs for decrypting SSE-KMS protected artifacts."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Key-value map of common tags applied to the IAM role. Merged with Service = 'CodePipeline'."
  type        = map(string)
  default     = {}
}
