variable "project_log_group_name" {
  description = "Full name for the CodeBuild (project) CloudWatch log group. Typically derived and passed from the top-level pipeline."
  type        = string
}

variable "pipeline_log_group_name" {
  description = "Full name for the CodePipeline CloudWatch log group. Typically derived and passed from the top-level pipeline."
  type        = string
}

variable "log_retention_days" {
  description = "Retention period in days for CloudWatch Log Groups. Defaults to 90 days but can be overridden via tfvars."
  type        = number
  default     = 90
}

variable "kms_key_arn" {
  description = "Optional KMS key ARN used to encrypt CloudWatch logs. If null, service-managed encryption is applied."
  type        = string
  default     = null
}

variable "tags" {
  description = "Key-value map of common tags applied to all resources. These are merged with default CloudWatch tags."
  type        = map(string)
  default     = {}
}
