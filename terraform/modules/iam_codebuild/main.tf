locals {
  default_tags = {
    Service = "CodeBuild"
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "martini_codebuild_role" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags               = merge(local.default_tags, var.tags)
}

data "aws_iam_policy_document" "codebuild_permissions" {
  statement {
    sid = "CloudWatchLogsAccess"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams"
    ]
    resources = [
      var.project_log_group_arn,
      "${var.project_log_group_arn}:*"
    ]
  }

  statement {
    sid     = "S3ArtifactAccess"
    actions = [
      "s3:ListBucket"
    ]
    resources = [
      var.artifact_bucket_arn
    ]
  }

  statement {
    sid     = "S3ArtifactObjects"
    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = [
      "${var.artifact_bucket_arn}/*"
    ]
  }

  statement {
    sid = "SSMReadParameter"
    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters"
    ]
    resources = [
      var.ssm_parameter_arn
    ]
  }

  dynamic "statement" {
    for_each = var.ecr_repo_arn == null ? [] : [1]

    content {
      sid = "ECRPushAccess"
      actions = [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "ecr:InitiateLayerUpload",
        "ecr:UploadLayerPart",
        "ecr:CompleteLayerUpload",
        "ecr:PutImage",
        "ecr:DescribeRepositories"
      ]
      resources = [
        var.ecr_repo_arn,
        "${var.ecr_repo_arn}:*"
      ]
    }
  }

  dynamic "statement" {
    for_each = length(var.kms_key_arns) == 0 ? [] : [1]

    content {
      sid       = "KMSDecrypt"
      actions   = ["kms:Decrypt"]
      resources = var.kms_key_arns
    }
  }
}

resource "aws_iam_role_policy" "martini_codebuild_inline" {
  name   = "martini-codebuild-policy"
  role   = aws_iam_role.martini_codebuild_role.id
  policy = data.aws_iam_policy_document.codebuild_permissions.json
}
