
#resource "aws_iam_role" "iam_for_lambda" {
#  name               = "iam_for_lambda"
#  assume_role_policy = data.aws_iam_policy_document.assume_role.json
#}

resource "aws_lambda_function" "lambdas" {
 function_name = var.func_name
 #image_uri=data.external.check_digest.result.imagedigest
 image_uri="${data.external.check_repo.result.repository_url}@${data.external.check_digest.result.imagedigest}"
 package_type  = "Image"

 role=aws_iam_role.role.arn

# ... other configuration ...
#  depends_on = [
#    aws_iam_role_policy_attachment.lambda_logs,
#    aws_cloudwatch_log_group.example,
#  ]
}
resource "aws_iam_role" "role" {
  name = var.iam_role_name

  assume_role_policy = jsonencode({
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}
