module "ecr" {
    source = "./modules/ecr"
    #repository_name = var.repository_name    
}

module "deploy_lambda" {
    source="./modules/deploy_lambda"
    repository_name = var.repository_name
    region=var.region
    func_name=var.lambda_deploy_func_name
    iam_role_name=var.lambda_deploy_iam_role_name
    image_uri=""
}

module "deploy_apigateway"{
      source="./modules/deploy_apigateway"
      function_name=module.deploy_lambda.function_name
      invoke_arn=module.deploy_lambda.invoke_arn
      apigw_name=var.deploy_apigateway_name
}
module "oidc"{
  source="./modules/oidc"
}
module "webhook_lambda"{
 source="./modules/deploy_lambda"
    repository_name = var.repository_name
    region=var.region
    func_name=var.lambda_webhook_func_name
    iam_role_name=var.lambda_webhook_iam_role_name
    image_uri=""
}
module "webhook_apigateway"{
      source="./modules/deploy_apigateway"
      function_name=module.webhook_lambda.function_name
      invoke_arn=module.webhook_lambda.invoke_arn
      apigw_name=var.deploy_apigateway_name
}
