
# Create the OIDC Provider in the AWS Account
resource "aws_iam_openid_connect_provider" "github_actions" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.github.certificates[0].sha1_fingerprint]
}

# Create an IAM Role that can be assumed by Actions Runners running
# against repos in the list
resource "aws_iam_role" "gha_oidc_assume_role" {
  name = "gha_oidc_assume_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${aws_iam_openid_connect_provider.github_actions.arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "token.actions.githubusercontent.com:aud": "sts.amazonaws.com",
          },
          "StringLike" : {
            "token.actions.githubusercontent.com:sub" : ["repo:zxver1000/*"]
          }
        }
      }
    ]
  })
}

# Attach a policy to the role allowing whatever you need for Terraform
# To do its thing
resource "aws_iam_role_policy" "gha_oidc_terraform_permissions" {
  name = "gha_oidc_terraform_permissions"
  role = aws_iam_role.gha_oidc_assume_role.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.


  # oidc 로 하는것 
  # updateimage 이미지 업로드 -> 권한 oidc로주기 
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
          Action=[
          "iam:CreateRole",
          "iam:CreatePolicy",
          "iam:DeleteRole",
          "iam:PutRolePolicy",
          "iam:DeleteRolePolicy",
          "ecr:GetAuthorizationToken",

       ],
       Effect   = "Allow"
      Resource="*"
      }
      ,{
        Action = [
         "ecr:BatchGetImage",
        "ecr:BatchCheckLayerAvailability",
        "ecr:CompleteLayerUpload",
        "ecr:DescribeImages",
        "ecr:DescribeRepositories",
        "ecr:GetDownloadUrlForLayer",
        "ecr:InitiateLayerUpload",
        "ecr:ListImages",
        "ecr:PutImage",
        "ecr:UploadLayerPart",
        ]
        Effect   = "Allow"
        Resource = "arn:aws:ecr:ap-northeast-2:*"
      }
    ]
  })
}

