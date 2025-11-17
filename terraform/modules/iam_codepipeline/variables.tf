variable "role_name" {
  description = "Name of the IAM role for CodePipeline."
  type        = string
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
  description = "Key-value map of common tags applied to the IAM role. Merged with default CodePipeline tag."
  type        = map(string)
  default     = {}
}
