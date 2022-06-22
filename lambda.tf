resource "aws_iam_role" "iam_for_lambda" {
  name = "${var.prefix}_iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": [
          "lambda.amazonaws.com",
          "edgelambda.amazonaws.com"
        ]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "basic_auth_lambda" {
  provider         = aws.use1
  filename         = "basic_auth_lambda.zip"
  function_name    = "${var.prefix}_basic_auth"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "basic_auth.handler"
  source_code_hash = data.archive_file.basic_auth_lambda_zip.output_base64sha256
  runtime          = "nodejs14.x"

  publish = true
}
