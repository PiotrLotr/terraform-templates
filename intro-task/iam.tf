resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"
  assume_role_policy = <<EOF
{
    "Version":"2012-10-17",
    "Statement":[
        {
            "Action":"sts:AssumeRole",
            "Principal":{
                "Service":"lambda.amazonaws.com"
            },
            "Effect":"Allow",
            "Sid":""
        }
    ]
}
  EOF
}

resource "aws_iam_policy" "s3_bucket_access" {
  name        = "s3_bucket_access"
  description = "A test policy"

policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::s3-bucket"
        }
    ]
  }
  EOF
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.s3_bucket_access.arn
}