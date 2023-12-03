
#resource "aws_iam_role" "iam_for_lambda" {
#  name               = "iam_for_lambda"
#  assume_role_policy = data.aws_iam_policy_document.assume_role.json
#}

resource "aws_lambda_function" "lambdas" {
 function_name = var.func_name
 #image_uri=data.external.check_digest.result.imagedigest
 image_uri="${data.external.check_repo.result.repository_url}@${data.external.check_digest.result.imagedigest}"
 package_type  = "Image"
 architectures=["arm64"]

 role=aws_iam_role.role.arn

# ... other configuration ...
#  depends_on = [
#    aws_iam_role_policy_attachment.lambda_logs,
#    aws_cloudwatch_log_group.example,
#  ]
}
resource "aws_iam_role" "role" {
  name = var.iam_role_name
  managed_policy_arns=[aws_iam_policy.UpdatelambdaPolicy.arn]

  assume_role_policy = jsonencode({
    Statement = [
      {
        Action =  "sts:AssumeRole"
        
        #AssumRole 이란 -> 일시적으로 리소스 권한 부여하는것 lambda함수가 aws접근이 가능하게 함
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com",
        }
      }
      
    ]
  }
  )
}

# Action 제한 
# lambda -> updateimage
# ecr-> image get필요

resource "aws_iam_policy" "UpdatelambdaPolicy" {
  name = "update-Lambda-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [
          "lambda:*",
          "ecr:*"
          ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
