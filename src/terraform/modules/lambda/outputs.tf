output "function_name" {
 value=aws_lambda_function.lambdas.function_name
 
}
output "invoke_arn" {
    value=aws_lambda_function.lambdas.invoke_arn
}