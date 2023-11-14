resource "aws_apigatewayv2_api" "gate" {
  name          = "thankyou"
  protocol_type = "HTTP"
}

#stage 만들기
resource "aws_apigatewayv2_stage" "stage" {
  api_id = aws_apigatewayv2_api.gate.id
  name   = "$default"
  auto_deploy=true
}


## lambda 랑 apigateway 연결하기
resource "aws_apigatewayv2_integration" "api_lambda" {
  api_id = aws_apigatewayv2_api.gate.id
  integration_type = "AWS_PROXY"

  connection_type           = "INTERNET"
  description               = "Lambda example"
  integration_method        = "POST"
  integration_uri           = var.invoke_arn  
}

#라우터 추가하고 넣기 끝
resource "aws_apigatewayv2_route" "gate_route" {
  api_id    = aws_apigatewayv2_api.gate.id
  route_key = "GET /"
  target    = "integrations/${aws_apigatewayv2_integration.api_lambda.id}"
}

resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "${aws_apigatewayv2_api.gate.execution_arn}/*/*"
}