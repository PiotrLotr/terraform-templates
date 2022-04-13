
resource "aws_lambda_function" "function_lambda" {

  function_name = "lambda-function"
  filename      = "lambda.zip"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "handler"
  runtime       = "python3.7"

  environment {
    variables = {
      BUCKET_ARN = "arn:aws:s3:::s3-bucket"
    }
  }
}