variable "repository_name" {
  description = "Name of the ECR repository (e.g., martini-build-image)."
  type        = string
}

variable "kms_key_arn" {
  description = "Optional KMS key ARN for ECR image encryption. If null, AES256 encryption is used."
  type        = string
  default     = null
}

variable "scan_on_push" {
  description = "Enable image vulnerability scanning on push."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Key-value map of tags applied to the repository. Merged with default Service = 'ECR' tag."
  type        = map(string)
  default     = {}
}
