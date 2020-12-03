variable "locals_function" {
  type = object({
    name                           = string
    role                           = string
    handler                        = string
    runtime                        = string
    timeout                        = number
    memory_size                    = number
    reserved_concurrent_executions = number
    source_code_hash               = string
    publish                        = bool
  })

  default = {
    name                           = null 
    role                           = null
    handler                        = null
    runtime                        = "java11"
    reserved_concurrent_executions = -1
    source_code_hash               = null
    publish                        = true
    timeout                        = 60
    memory_size                    = 1536
  }
}

variable "function" {
  default = null
}

variable "create_default_log_group" { 
  default = 0
}

variable "subnet_ids" {
  type        = list(string)
  description = "The VPC subnets in which the Lambda runs."
  default     = ""
}

variable "security_group_ids" {
  type        = list(string)
  description = "The VPC security groups assigned to the Lambda."
  default     = ""
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


variable "lambda_env" {
  description = "Environment parameters passed to the Lambda function."
  type        = map(string)
  default     = {}
}

variable "environment_vars" {
  description = "Map of environment variables"
  type        = map(string)
  default     = null
}

variable "tags" {
  description = "Tags to assign to the Function"
  type        = map(string)
  default     = {}
}
