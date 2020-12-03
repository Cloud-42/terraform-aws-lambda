module "lambda" {
  source = "git::https://github.com/Cloud-42/terraform-aws-lambda.git"
  function = ({
    name    = var.function_name
    role    = var.function_role
    handler = var.handler
  })

  s3 = ({
    bucket = "my-s3-source-bucket"
    key    = "file.jar.zip"
  })
}
