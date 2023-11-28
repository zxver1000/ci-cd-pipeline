data "external" "check_repo" {
  program = ["/bin/bash", "${path.module}/script.sh", var.repository_name, var.region]
 
}

data "external" "check_digest"{
 program=["/bin/bash", "${path.module}/digest.sh", var.repository_name, var.region]
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}