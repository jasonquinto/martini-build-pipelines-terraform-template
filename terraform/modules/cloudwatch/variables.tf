variable "project_log_group_name" {
  description = "Name of the CloudWatch log group for the CodeBuild project."
  type        = string
}

variable "pipeline_log_group_name" {
  description = "Name of the CloudWatch log group for the CodePipeline."
  type        = string
}

variable "log_retention_days" {
  description = "Retention period in days for CloudWatch Log Groups."
  type        = number
  default     = 90
}

variable "kms_key_arn" {
  description = "Optional KMS key ARN for encrypting CloudWatch Logs. If null, AWS-managed keys are used."
  type        = string
  default     = null
}

variable "tags" {
  description = "Key-value map of common tags applied to the CloudWatch log groups. Merged with default CloudWatch tags."
  type        = map(string)
  default     = {}
}
