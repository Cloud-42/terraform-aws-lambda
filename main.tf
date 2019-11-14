# ------------------------------------------------
# Lambda function	
# ------------------------------------------------
resource "aws_lambda_function" "function" {
  s3_bucket                      = var.s3_bucket
  s3_key                         = var.s3_key
  function_name                  = var.function_name
  role                           = aws_iam_role.iam.arn
  handler                        = var.handler
  runtime                        = var.runtime
  timeout                        = var.timeout
  memory_size                    = var.memory_size
  reserved_concurrent_executions = var.reserved_concurrent_executions

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
}

resource "aws_cloudwatch_log_group" "loggroup" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = 7
  depends_on        = [aws_lambda_function.function]
}

