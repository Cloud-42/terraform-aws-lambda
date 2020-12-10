# --------------------------------------
# Lambda functions
# --------------------------------------
module "lambda" {
  source = "git::https://github.com/Cloud-42/terraform-aws-lambda.git"

  for_each = {
    for item in var.functions : item.function => item
  }

  function = ({
    name             = "${each.key}"
    role             = "arn:aws:iam::0123456789:role/lambda-default-role"
    handler          = each.value.handler
    filename         = each.value.filename
    source_code_hash = filebase64sha256("./${each.value.filename}")
  })
  environment_vars = {
    VAR-CACHE      = each.key == "lambda-2" ? "APPLY" : null
    VAR_TOPIC_NAME = "arn:aws:sns:${var.aws_region}:${data.aws_caller_identity.current.account_id}:topic-name-${each.key}"
    VAR_ARN        = data.terraform_remote_state.shared.aws_sns_topic_arn
  }
  tags = merge(
    local.main_tags,
    {
      "Name" = "${each.key}-lambda"
    },
  )
}

variable "functions" {
  default = [
    {
      function : "lambda-1"
      filename : "./lambda-1.jar"
      handler : "com.lambda.beta.lambda1.handler.Handler::handleEvent"
    },
    {
      function : "lambda-2"
      filename : "./lambda-2.jar"
      handler : "com.lambda.beta.lambda2.handler.Handler::handleEvent"
    },
    {
      function : "lambda-3"
      filename : "./lambda-1.jar"
      handler : "com.lambda.beta.lambda3.handler.Handler::handleEvent"
    }
  ]
}
