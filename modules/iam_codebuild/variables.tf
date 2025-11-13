variable "role_name" {
  description = "Name of the IAM role created for the CodeBuild project (e.g., martini-codebuild-role-dev)."
  type        = string
}

variable "policy_name" {
  description = "Name of the inline IAM policy attached to the CodeBuild role."
  type        = string
  default     = "martini-codebuild-policy"
}

variable "project_log_group_arn" {
  description = "ARN of the CloudWatch Logs log group used by the CodeBuild project (from the cloudwatch module)."
  type        = string
}

variable "artifact_bucket_arn" {
  description = "ARN of the S3 artifact bucket used for CodePipeline/CodeBuild artifacts."
  type        = string
}

variable "artifact_object_prefix" {
  description = "Optional object key prefix within the artifact bucket to further restrict S3 access (e.g., 'build/'). If null, access applies to the entire bucket."
  type        = string
  default     = null
}

variable "ssm_parameter_arn" {
  description = "ARN of the single SSM SecureString parameter the build should read."
  type        = string
}

variable "ecr_repo_arn" {
  description = "Optional ARN of the ECR repository for push/pull permissions. If null, ECR permissions are omitted."
  type        = string
  default     = null
}

variable "kms_key_arns" {
  description = "Optional list of KMS key ARNs for decrypting SSE-KMS protected S3/SSM artifacts."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Key-value map of common tags to apply to the IAM role. Merged with default Service = 'CodeBuild'."
  type        = map(string)
  default     = {}
}
