locals {
  default_tags = {
    Service = "CodePipeline"
  }
}

# Trust relationship for CodePipeline
data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "martini_codepipeline_role" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags               = merge(local.default_tags, var.tags)
}

# Inline policy with scoped privileges
data "aws_iam_policy_document" "codepipeline_permissions" {
  # --- CodeStar Connection: use a single connection ARN for GitHub
  statement {
    sid       = "CodeStarConnection"
    actions   = ["codestar-connections:UseConnection"]
    resources = [var.codestar_connection_arn]
  }

  # --- S3: read/write artifacts in the designated artifact bucket
  statement {
    sid     = "S3ArtifactAccess"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket",
      "s3:DeleteObject"
    ]
    resources = [
      var.artifact_bucket_arn,
      "${var.artifact_bucket_arn}/*"
    ]
  }

  # --- PassRole: allow CodePipeline to invoke CodeBuild
  statement {
    sid       = "PassRoleToCodeBuild"
    actions   = ["iam:PassRole"]
    resources = [var.codebuild_role_arn]
  }

  # --- Optional: KMS decrypt for artifact encryption
  dynamic "statement" {
    for_each = length(var.kms_key_arns) == 0 ? [] : [1]
    content {
      sid       = "KMSDecrypt"
      actions   = ["kms:Decrypt"]
      resources = var.kms_key_arns
    }
  }

  # --- CloudWatch Events (optional basic event publishing)
  statement {
    sid       = "CloudWatchEvents"
    actions   = [
      "events:PutRule",
      "events:DeleteRule",
      "events:PutTargets",
      "events:RemoveTargets",
      "events:DescribeRule"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "martini_codepipeline_inline" {
  name   = var.policy_name
  role   = aws_iam_role.martini_codepipeline_role.id
  policy = data.aws_iam_policy_document.codepipeline_permissions.json
}
