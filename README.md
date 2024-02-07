<p align="center">
  <a href="https://www.cloud42.io/" target="_blank" rel="Homepage">
  <img width="200" height="200" src="https://www.cloud42.io/wp-content/uploads/2020/01/transparent_small.png">
  </a>
</p>

---
<p align="center">Need help with your Cloud builds <a href="https://www.cloud42.io/contact/" target="_blank" rel="ContactUS"> GET IN TOUCH</a>.</p>

---
## Lambda function 

Upon launching the following resources will be created:

 * Lambda function
 * Default CW log group: OPTIONAL 

## Dependencies and Prerequisites
 * Terraform v1.0.0 or higher
 * AWS account

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.loggroup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_lambda_function.function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_default_log_group"></a> [create\_default\_log\_group](#input\_create\_default\_log\_group) | OPTIONAL: Whether to create default log group. Set to 1 to create | `number` | `1` | no |
| <a name="input_environment_vars"></a> [environment\_vars](#input\_environment\_vars) | Map of environment variables | `map(string)` | `null` | no |
| <a name="input_ephemeral_storage"></a> [ephemeral\_storage](#input\_ephemeral\_storage) | The amount of Ephemeral storage(/tmp) to allocate for the Lambda Function in MB. | `number` | `"512"` | no |
| <a name="input_function"></a> [function](#input\_function) | Lambda function variables - merged will locals to create configuration | `map(any)` | `null` | no |
| <a name="input_locals_function"></a> [locals\_function](#input\_locals\_function) | n/a | <pre>object({<br>    filename                       = string<br>    name                           = string<br>    role                           = string<br>    handler                        = string<br>    runtime                        = string<br>    timeout                        = number<br>    memory_size                    = number<br>    reserved_concurrent_executions = number<br>    source_code_hash               = string<br>    publish                        = bool<br>    package_type                   = string<br>  })</pre> | <pre>{<br>  "filename": null,<br>  "handler": null,<br>  "memory_size": 128,<br>  "name": null,<br>  "package_type": "Zip",<br>  "publish": true,<br>  "reserved_concurrent_executions": -1,<br>  "role": null,<br>  "runtime": "java11",<br>  "source_code_hash": null,<br>  "timeout": 60<br>}</pre> | no |
| <a name="input_locals_s3"></a> [locals\_s3](#input\_locals\_s3) | n/a | <pre>object({<br>    bucket         = string<br>    key            = string<br>    object_version = string<br>  })</pre> | <pre>{<br>  "bucket": null,<br>  "key": null,<br>  "object_version": null<br>}</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"eu-west-1"` | no |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | Log retention in dayes | `number` | `7` | no |
| <a name="input_s3"></a> [s3](#input\_s3) | OPTIONAL: s3 object to specify function location in s3 - merged with locals to create configuration | `map(any)` | `null` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | OPTIONAL: The VPC security groups to assign to the Lambda. | `list(string)` | `[]` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | OPTIONAL: The VPC subnets in which the Lambda runs. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to assign to the Function | `map(string)` | `{}` | no |
| <a name="input_tracing_config"></a> [tracing\_config](#input\_tracing\_config) | Tracing config. Can be either PassThrough or Active | `string` | `"Active"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_function"></a> [lambda\_function](#output\_lambda\_function) | n/a |

## Usage

To import the module add the following to your TF file:
```
module "lambda" {
  source  = "Cloud-42/lambda/aws"
  version = "3.1.0"  # Or required version
  function = ({
    name        = var.function_name
    role        = var.function_role
    handler     = var.handler
    filename    = "./lambda.zip"
    runtime     = "python3.9"
    memory_size = "512"
    timeout     = "600"
  })

  ephemeral_storage = "10240"

  s3 = ({
    bucket = "my-s3-source-bucket"
    key    = "file.jar.zip"
  })

  environment_vars = {
    ENV_VAR = "${var.ENV_VAR}"
  }
}
```
* To initialise the module run: terraform init
* To update the module run    : terraform get --update
* To see a plan of changes    : terraform plan
* To apply                    : terraform apply 
* To automatically apply      : terraform apply --auto-approve
