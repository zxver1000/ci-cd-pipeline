variable "repository_name"{
   default="kk"
    type=string
}
variable "region"{
    default="ap-northeast-2"
    type=string
}
variable "accountId"{
    default=455883942660
    type=string
}

variable "lambda_deploy_func_name"{
    default="koko"
}
variable "lambda_deploy_iam_role_name"{
    default="deploy_iam_role"
}
variable "deploy_apigateway_name"{
   default="hihi"
}
variable "lambda_webhook_func_name"{
    default="webhook"
}
variable "lambda_webhook_iam_role_name"{
    default="webhook_iam_role"
}
variable "webhook_apigateway_name"{
   default="webhook"
}
