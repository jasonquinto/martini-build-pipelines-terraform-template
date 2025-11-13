variable "bucket_name" {
  description = "Name of the S3 bucket used for CodePipeline and CodeBuild artifacts."
  type        = string
}

variable "kms_key_arn" {
  description = "Optional KMS key ARN to use for bucket encryption. If null, AES256 encryption is used."
  type        = string
  default     = null
}

variable "tags" {
  description = "Key-value map of common tags applied to the S3 artifact bucket. Merged with default S3 tags."
  type        = map(string)
  default     = {}
}
