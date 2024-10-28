# Define the app name for consistency
variable "app_name" {
  default = "PythonAppCodeBuild"  
}

# Assume the default service role created by CodeBuild
resource "aws_iam_role" "codebuild_default_role" {
  name               = "CodeBuildBasePolicy-${var.app_name}-us-east-1"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# CodeBuild base policy
resource "aws_iam_policy" "codebuild_base_policy" {
  name        = "CodeBuildBasePolicy-${var.app_name}"
  description = "Policy for ${var.app_name} CodeBuild"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": [
        "arn:aws:logs:us-east-1:009160050878:log-group:CodeBuildDockerDemo",
        "arn:aws:logs:us-east-1:009160050878:log-group:CodeBuildDockerDemo:*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "codebuild:BatchGetBuilds",
        "codebuild:StartBuild",
        "codebuild:StopBuild",
        "codebuild:ListBuildsForProject"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

# Attach the base policy to the default CodeBuild role
resource "aws_iam_role_policy_attachment" "codebuild_base_policy_attachment" {
  role       = aws_iam_role.codebuild_default_role.name
  policy_arn = aws_iam_policy.codebuild_base_policy.arn
}


# Policy for CodeStar Connections in CodeBuild
resource "aws_iam_policy" "codebuild_connections_policy" {
  name        = "CodeBuildConnectionsPolicy-${var.app_name}"
  description = "Policy for CodeStar Connections in CodeBuild"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "codestar-connections:GetConnectionToken",
        "codestar-connections:GetConnection",
        "codeconnections:GetConnectionToken",
        "codeconnections:GetConnection",
        "codeconnections:UseConnection"
      ],
      "Resource": [
        "arn:aws:codeconnections:us-east-1:009160050878:connection/e45787a2-fc5d-453f-a71f-58608f57d13b",
        "arn:aws:codeconnections:us-east-1:${var.account_id}:connection/e45787a2-fc5d-453f-a71f-58608f57d13b"
      ]
    }
  ]
}
EOF
}

# Attach the connections policy to the default CodeBuild role
resource "aws_iam_role_policy_attachment" "codebuild_connections_policy_attachment" {
  role       = aws_iam_role.codebuild_default_role.name
  policy_arn = aws_iam_policy.codebuild_connections_policy.arn
}

# Policy for CloudWatch Logs in CodeBuild
resource "aws_iam_policy" "codebuild_cloudwatch_logs_policy" {
  name        = "CodeBuildCloudWatchLogsPolicy-${var.app_name}"
  description = "Policy for CloudWatch Logs in CodeBuild"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": [
        "arn:aws:logs:us-east-1:009160050878:log-group:CodeBuildDockerDemo",
        "arn:aws:logs:us-east-1:009160050878:log-group:CodeBuildDockerDemo:*"
      ]
    }
  ]
}
EOF
}

# Attach the CloudWatch Logs policy to the default CodeBuild role
resource "aws_iam_role_policy_attachment" "codebuild_cloudwatch_logs_policy_attachment" {
  role       = aws_iam_role.codebuild_default_role.name
  policy_arn = aws_iam_policy.codebuild_cloudwatch_logs_policy.arn
}

# Attach the AWS Managed Policy to the default service role
resource "aws_iam_role_policy_attachment" "attach_ec2_instance_profile_policy" {
  role       = aws_iam_role.codebuild_default_role.name
  policy_arn = "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilderECRContainerBuilds"
}
