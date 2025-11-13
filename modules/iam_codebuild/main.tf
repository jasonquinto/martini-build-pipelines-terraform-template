locals {
  default_tags = {
    Service = "CodeBuild"
  }
}

# Trust policy for CodeBuild
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

# Inline policy - least-privilege
data "aws_iam_policy_document" "codebuild_permissions" {
  # --- CloudWatch Logs: scope to the specific project log group
  statement {
    sid     = "CloudWatchLogsAccess"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams"
    ]
    resources = [
      # log stream ARNs live under the log group ARN with :*
      "${var.project_log_group_arn}:*"
    ]
  }

  # --- S3: artifacts in a specific bucket (optionally path-scoped for objects)
  statement {
    sid     = "S3ListBucketArtifacts"
    actions = ["s3:ListBucket"]
    resources = [var.artifact_bucket_arn]

    # Optionally restrict the list operation to a prefix if provided
    dynamic "condition" {
      for_each = var.artifact_object_prefix == null ? [] : [1]
      content {
        test     = "StringLike"
        variable = "s3:prefix"
        values   = ["${var.artifact_object_prefix}*"]
      }
    }
  }

  statement {
    sid     = "S3GetPutArtifacts"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject" # Include if your build produces or cleans up objects; harmless if unused
    ]
    resources = var.artifact_object_prefix == null ? ["${var.artifact_bucket_arn}/*"] : ["${var.artifact_bucket_arn}/${var.artifact_object_prefix}*"]
  }

  # --- SSM: read a single SecureString parameter used by the build
  statement {
    sid     = "SSMReadParameter"
    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:GetParameterHistory"
    ]
    resources = [var.ssm_parameter_arn]
  }

  # --- Optional: ECR (only when building/pushing images)
  dynamic "statement" {
    for_each = var.ecr_repo_arn == null ? [] : [1]
    content {
      sid     = "ECRPushPull"
      actions = [
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "ecr:InitiateLayerUpload",
        "ecr:UploadLayerPart",
        "ecr:CompleteLayerUpload",
        "ecr:PutImage"
      ]
      resources = [var.ecr_repo_arn]
    }
  }

  # ECR auth token must be resource "*"
  dynamic "statement" {
    for_each = var.ecr_repo_arn == null ? [] : [1]
    content {
      sid       = "ECRAuthToken"
      actions   = ["ecr:GetAuthorizationToken"]
      resources = ["*"]
    }
  }

  # --- Optional: KMS decrypt for SSE-KMS S3/SSM artifacts
  dynamic "statement" {
    for_each = length(var.kms_key_arns) == 0 ? [] : [1]
    content {
      sid     = "KMSDecrypt"
      actions = [
        "kms:Decrypt"
      ]
      resources = var.kms_key_arns
    }
  }
}

resource "aws_iam_role_policy" "martini_codebuild_inline" {
  name   = var.policy_name
  role   = aws_iam_role.martini_codebuild_role.id
  policy = data.aws_iam_policy_document.codebuild_permissions.json
}
