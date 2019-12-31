variable "source_code_hash" {
  description = "Lambda source code hash"
  default     = null
}

variable "function_name" {
  description = "Lambda function name."
}

variable "s3_bucket" {
  description = "s3 bucket containing the Lambda package.** Bucket MUST be in the same region as the Lambda. "
}

variable "s3_key" {
  description = "s3 key for your Lambda package."
}

variable "handler" {
  description = "The function within your code that Lambda calls to begin execution."
}

variable "runtime" {
  description = "Runtime environment for the Lambda function."
  default     = "java8"
}

variable "subnet_ids" {
  type        = list(string)
  description = "The VPC subnets in which the Lambda runs."
}

variable "security_group_ids" {
  type        = list(string)
  description = "The VPC security groups assigned to the Lambda."
}

variable "lambda_policy" {
  description = "The Lambda IAM Role Policy."
  default     = <<ROLE
{
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*"
    },
    {
      "Effect": "Allow",
         "Action": [
          "ssm:GetParameters",
          "ssm:GetParameter",
          "ssm:GetParametersByPath"
       ],
       "Resource": "*"
    }
  ]
}
ROLE

}

variable "timeout" {
  description = "The maximum time in seconds that the Lambda can run for."
  default     = 60
}

variable "memory_size" {
  description = "Amount of memory in MB your Lambda Function can use at runtime."
  default     = 320
}

variable "lambda_env" {
  description = "Environment parameters passed to the Lambda function."
  type        = map(string)
  default     = {}
}

variable "reserved_concurrent_executions" {
  description = "Reserved concurrent executions for this Lambda"
  default     = -1
}

variable "environment_vars" {
  description = "Map of environment variables"
  type    = map(string)
  default = null
}

