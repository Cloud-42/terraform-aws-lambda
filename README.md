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
 * Terraform v0.13.2 or higher
 * AWS account

## Variables
| Variable | Meaning | Optional |
| :------- | :----- | :----- |
| `environment_vars` | Map of environment variables to be created | Yes |
| `function` | Object variable for Lambda config | No |
| `s3` | Object variable for s3 config | Yes 
| `locals_function` | Local object variable for Lambda config - merged with var.function | N/A |
| `locals_s3` | Local object variable for s3 source config - merged with var.s3  |  N/A |
| `create_default_log_group` | Whether to create default log group. Set to 1 to create | Yes |
| `subnet_ids` | List of subnet ids | Yes |
| `security_group_ids` | List of security group ids | Yes |
| `tracing_config` | Tracing config. Can be either PassThrough or Active  | Yes |
| `tags` | Map of tags to apply | Yes |

## Outputs
 * lambda\_function 

## Usage

To import the module add the following to your TF file:
```
module "lambda" {
  source  = "Cloud-42/lambda/aws"
  version = "3.0.0"  # Or required version
  function = ({
    name    = var.function_name
    role    = var.function_role
    handler = var.handler
  })

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
