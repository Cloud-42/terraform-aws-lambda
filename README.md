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

 * CW Logs log group
 * IAM Role
 * IAM Policies, see below:
 * Lambda function 

## Dependencies and Prerequisites
 * Terraform v0.12. or higher
 * AWS account

## IAM Role and attachments
 * AWS Service policy - AWSLambdaVPCAccessExecutionRole   - Attached to role if subnets= is specified
 * AWS Service policy - AWSLambdaSQSQueueExecutionRole    - Always attached
 * AWS Service policy - AWSLambdaBasicExecutionRole       - Always attached
 * var.lambda_policy - Can be used to add a custom policy - Default policy grants CWLogs access and Parameter Store access 

## Variables
| Variable | Meaning |
| :------- | :----- |
| `environment_vars` | Map of environment variables to be created |
| `function_name` | Function name |
| `handler` | Lambda handler |
| `s3_bucket` | s3 bucket where the function code can be found  |
| `s3_key` | s3 key / file name of the function code |
| `security_group_ids` | Security groups to assign to the Lambda |
| `source_code_hash` | Source code hash ( Default = Null ) |
| `subnet_ids` | The subnets in which the Lambda runs  |
| `memory_size` | Memory allocation  |
| `reserved_concurrent_executions` | Reserved concurrent executions ( Default = unreserved )  |
| `runtime` | Runtime environment  |
| `timeout` | Maximum timeout in seconds  |

## Outputs
 * lambda\_function 

## Usage

To import the module add the following to your TF file:
```
module "lambda" {
  source  = "Cloud-42/lambda/aws"
  version = "1.1.0"  # Or required version

  function_name      = "${var.function_name}"
  handler            = var.handler
  security_group_ids = [var.security_group_ids]
  s3_bucket          = var.s3_deployment_bucket
  s3_key             = var.s3_deployment_artifact
  source_code_hash   = var.function_source_code_hash
  subnet_ids         = "${var.subnet_ids}"

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
