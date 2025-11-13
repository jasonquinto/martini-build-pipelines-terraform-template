variable "pipeline_name" {
  description = "Canonical name for this pipeline. Used for naming resources and buildspec lookup."
  type        = string
  default     = "martini-build-image"
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
    Example: ../buildspecs/martini-build-image.yaml
  DESC
  type        = string
  default     = "../buildspecs/martini-build-image.yaml"
}

variable "codestar_connection_arn" {
  description = "ARN of the AWS CodeStar Connection for GitHub."
  type        = string
}

variable "martini_version" {
  description = "Version of the Martini runtime to include in the Docker image."
  type        = string
  default     = "latest"
}

variable "log_retention_days" {
  description = "Retention period in days for CloudWatch log groups."
  type        = number
  default     = 90
}

variable "kms_key_arn" {
  description = "Optional KMS key ARN for encryption of logs, S3, SSM, and artifacts."
  type        = string
  default     = null
}

variable "tags" {
  description = "Map of custom tags applied to all resources. Merged with Project, Environment, and Owner."
  type        = map(string)
  default     = {}
}
