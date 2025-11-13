variable "pipeline_name" {
  description = "Canonical name for this pipeline."
  type        = string
  default     = "martini-upload-package"
}

variable "environment" {
  description = "Deployment environment (e.g., dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "AWS region for deployment."
  type        = string
}

variable "repository_name" {
  description = "Full GitHub repository name (e.g., username/repo)."
  type        = string
}

variable "branch_name" {
  description = "Branch name for CodePipeline source trigger."
  type        = string
}

variable "buildspec_file" {
  description = <<-DESC
    Path to the buildspec file relative to this pipeline directory.
    Defaults to the shared /buildspecs folder with a name matching the pipeline.
    Example: ../buildspecs/martini-upload-package.yaml
  DESC
  type        = string
  default     = "../buildspecs/martini-upload-package.yaml"
}

variable "codestar_connection_arn" {
  description = "ARN of the AWS CodeStar Connection for GitHub."
  type        = string
}

variable "base_url" {
  description = "URL of the target Martini runtime server to which packages are uploaded."
  type        = string
}

variable "martini_access_token" {
  description = "Long-lived OAuth token used to authenticate with the Martini runtime."
  type        = string
  sensitive   = true
}

variable "async_upload" {
  description = "Whether to treat HTTP 504 as successful upload (asynchronous mode)."
  type        = bool
  default     = false
}

variable "success_check_delay" {
  description = "Delay (seconds) between polling attempts for upload status."
  type        = number
  default     = 30
}

variable "success_check_timeout" {
  description = "Maximum number of polling attempts for upload status verification."
  type        = number
  default     = 6
}

variable "log_retention_days" {
  description = "CloudWatch log retention period in days."
  type        = number
  default     = 90
}

variable "kms_key_arn" {
  description = "Optional KMS key ARN for encrypting logs, S3, and SSM parameters."
  type        = string
  default     = null
}

variable "tags" {
  description = "Map of additional tags applied to all resources."
  type        = map(string)
  default     = {}
}
