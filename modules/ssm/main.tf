locals {
  default_tags = {
    Service = "SSM"
  }
}

resource "aws_ssm_parameter" "martini_ssm_parameter" {
  name        = var.parameter_name
  description = var.parameter_description
  type        = "SecureString"
  value       = var.parameter_value
  key_id      = var.kms_key_arn
  overwrite   = var.overwrite

  tags = merge(local.default_tags, var.tags)
}
