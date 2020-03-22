output "api_id" {
  value = aws_api_gateway_rest_api.api.id
}

output "api_resource" {
  value = aws_api_gateway_resource.r_control.path
}

output "invoke_url" {
  value = aws_api_gateway_stage.stage_api.invoke_url
}
