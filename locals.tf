locals {
  function        = merge(var.locals_function, var.function)
  environment_map = var.environment_vars == null ? [] : [var.environment_vars]
}
