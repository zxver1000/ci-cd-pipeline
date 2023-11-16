module "ecr" {
    source = "./modules/ecr"
    repository_name = var.repository_name
}

module "lambda" {
    source="./modules/lambda"
    repository_name = var.repository_name
    region=var.region
}

module "apigateway"{
      source="./modules/apigateway"
      function_name=module.lambda.function_name
      invoke_arn=module.lambda.invoke_arn
}
module "oicd"{
  source="./modules/oicd"
  


}