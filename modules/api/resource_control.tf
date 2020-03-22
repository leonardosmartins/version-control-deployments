resource "aws_api_gateway_resource" "r_control" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "control"
}

resource "aws_api_gateway_method" "control_POST" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.r_control.id
  http_method      = "POST"
  authorization    = "NONE"
  api_key_required = "false"
}

resource "aws_api_gateway_method_response" "control_POST_response_200" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.r_control.id
  http_method = aws_api_gateway_method.control_POST.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration" "control_POST_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.r_control.id
  http_method             = aws_api_gateway_method.control_POST.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = var.lambda_invoke_arn
}

resource "aws_api_gateway_integration_response" "control_POST_integration_response" {
    rest_api_id   = "${aws_api_gateway_rest_api.api.id}"
    resource_id   = "${aws_api_gateway_resource.r_control.id}"
    http_method   = "${aws_api_gateway_integration.control_POST_integration.http_method}"
    status_code   = "${aws_api_gateway_method_response.control_POST_response_200.status_code}"
}