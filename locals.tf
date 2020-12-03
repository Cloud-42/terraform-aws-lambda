locals {
  s3              = merge(var.locals_s3, var.s3)
  function        = merge(var.locals_function, var.function)
  environment_map = var.environment_vars == null ? [] : [var.environment_vars]
}
