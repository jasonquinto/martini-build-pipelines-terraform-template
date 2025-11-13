variable "parameter_name" {
  description = "Name for the SSM parameter."
  type = string
}

variable "parameter_description" {
  description = "Description of the SSM parameter to provide context about its purpose."
  type        = string
  default     = "Martini pipeline configuration parameter."
}

variable "parameter_value" {
  description = "The value to store in the SSM parameter."
  type      = string
  sensitive = true
}

variable "kms_key_arn" {
  description = "Optional KMS key ARN to encrypt the parameter. If null, AWS-managed key for SSM is used."
  type        = string
  default     = null
}

variable "overwrite" {
  description = "Whether to overwrite an existing parameter of the same name."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Common tags applied to the parameter. Merged with the default Service = 'SSM' tag."
  type        = map(string)
  default     = {}
}
