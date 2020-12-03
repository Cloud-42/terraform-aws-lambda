# ------------------------------------------------
# Lambda function	
# ------------------------------------------------
resource "aws_lambda_function" "function" {
  #s3_bucket                      = 
  #s3_key                         = var.function.s3_key
  function_name                  = locals.function.name
  role                           = locals.function.role
  handler                        = locals.function.handler
  runtime                        = locals.function.runtime
  timeout                        = locals.function.timeout
  memory_size                    = locals.function.memory_size
  reserved_concurrent_executions = locals.function.reserved_concurrent_executions
  source_code_hash               = locals.function.source_code_hash

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids
  }

  dynamic "environment" {
    for_each = local.environment_map
    content {
      variables = environment.value
    }
  }

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "loggroup" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = 7
  depends_on        = [aws_lambda_function.function]
}

