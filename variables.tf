variable "region" { default = "eu-west-1" }
variable "locals_function" {
  type = object({
    filename                       = string
    name                           = string
    role                           = string
    handler                        = string
    runtime                        = string
    timeout                        = number
    memory_size                    = number
    reserved_concurrent_executions = number
    source_code_hash               = string
    publish                        = bool
    package_type                   = string
  })

  default = {
    filename                       = null
    name                           = null
    role                           = null
    handler                        = null
    runtime                        = "java11"
    reserved_concurrent_executions = -1
    source_code_hash               = null
    publish                        = true
    timeout                        = 60
    memory_size                    = 128
    package_type                   = "Zip"
  }
}

variable "locals_s3" {
  type = object({
    bucket         = string
    key            = string
    object_version = string
  })

  default = {
    bucket         = null
    key            = null
    object_version = null
  }
}

variable "function" {
  description = "Lambda function variables - merged will locals to create configuration"
  type        = map(any)
  default     = null
}

variable "s3" {
  description = "OPTIONAL: s3 object to specify function location in s3 - merged with locals to create configuration"
  type        = map(any)
  default     = null
}

variable "create_default_log_group" {
  description = "OPTIONAL: Whether to create default log group. Set to 1 to create"
  type        = number
  default     = 1
}

variable "subnet_ids" {
  type        = list(string)
  description = "OPTIONAL: The VPC subnets in which the Lambda runs."
  default     = []
}

variable "security_group_ids" {
  type        = list(string)
  description = "OPTIONAL: The VPC security groups to assign to the Lambda."
  default     = []
}

variable "tracing_config" {
  description = "Tracing config. Can be either PassThrough or Active"
  default     = "Active"
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

variable "ephemeral_storage" {
  description = "The amount of Ephemeral storage(/tmp) to allocate for the Lambda Function in MB."
  type        = number
  default     = "512"
}

variable "retention_in_days" {
  description = "Log retention in dayes"
  type        = number
  default     = 7
}
