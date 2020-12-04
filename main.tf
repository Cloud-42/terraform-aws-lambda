# ------------------------------------------------
# Lambda function	
# ------------------------------------------------
resource "aws_lambda_function" "function" {
  s3_bucket                      = local.s3.bucket != null ? local.s3.bucket : null
  s3_key                         = local.s3.key != null ? local.s3.key : null
  s3_object_version              = local.s3.object_version != null ? local.s3.object_version : null
  filename                       = local.function.filename != null ? local.function.filename : null
  function_name                  = local.function.name
  role                           = local.function.role
  handler                        = local.function.handler
  runtime                        = local.function.runtime
  timeout                        = local.function.timeout
  memory_size                    = local.function.memory_size
  reserved_concurrent_executions = local.function.reserved_concurrent_executions
  source_code_hash               = local.function.source_code_hash
  publish                        = local.function.publish
  package_type                   = local.function.package_type

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

  tracing_config {
    mode = var.tracing_config
  }

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_cloudwatch_log_group" "loggroup" {
  count             = var.create_default_log_group
  name              = "/aws/lambda/${local.function.name}"
  retention_in_days = 7
  depends_on        = [aws_lambda_function.function]
}
