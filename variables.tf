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
    memory_size                    = 1536
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
  default = null
}

variable "s3" {
  default = null
}


variable "create_default_log_group" {
  default = 0
}

variable "subnet_ids" {
  type        = list(string)
  description = "The VPC subnets in which the Lambda runs."
  default     = []
}

variable "security_group_ids" {
  type        = list(string)
  description = "The VPC security groups assigned to the Lambda."
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
