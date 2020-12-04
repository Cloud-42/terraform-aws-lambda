module "lambda" {
  source = "git::https://github.com/Cloud-42/terraform-aws-lambda.git"
  function = ({
    name    = var.function_name
    role    = var.function_role
    handler = var.handler
    filename = "./file.jar.zip"
  })
}
