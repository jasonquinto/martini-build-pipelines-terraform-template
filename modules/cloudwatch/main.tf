locals {
  default_tags = {
    Service = "CloudWatch"
  }
}

# CodeBuild (Project) Log Group
resource "aws_cloudwatch_log_group" "martini_project_logs" {
  name              = var.project_log_group_name
  retention_in_days = var.log_retention_days
  kms_key_id        = var.kms_key_arn
  tags              = merge(local.default_tags, var.tags)
}

# CodePipeline Log Group
resource "aws_cloudwatch_log_group" "martini_pipeline_logs" {
  name              = var.pipeline_log_group_name
  retention_in_days = var.log_retention_days
  kms_key_id        = var.kms_key_arn
  tags              = merge(local.default_tags, var.tags)
}
