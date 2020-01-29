# ------------------------------------------------
# IAM
# ------------------------------------------------

resource "aws_iam_role" "iam" {
  name_prefix        = "${substr(var.function_name, 0, 22)}-"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF

}

resource "aws_iam_role_policy" "lambda_policy" {
  role   = aws_iam_role.iam.id
  name   = "policy"
  policy = var.lambda_policy
}

# ------------------------------------------------
# Attach standard policies
# ------------------------------------------------
resource "aws_iam_role_policy_attachment" "vpc_attach_permissions" {
  count      = length(var.subnet_ids) != 0 ? 1 : 0
  role       = aws_iam_role.iam.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource "aws_iam_role_policy_attachment" "sqs_attach_permissions" {
  role       = aws_iam_role.iam.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaSQSQueueExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda_execution_basic_attach_permissions" {
  role       = aws_iam_role.iam.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

