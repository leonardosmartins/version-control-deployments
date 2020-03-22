resource "aws_api_gateway_deployment" "first" {
  depends_on = [
    "aws_api_gateway_integration.control_POST_integration",
  ]
  rest_api_id = aws_api_gateway_rest_api.api.id
}