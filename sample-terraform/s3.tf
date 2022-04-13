
resource "aws_s3_bucket" "s3-bucket" {
  bucket = "${var.s3_bucket_name}-${terraform.workspace}"

  tags = {
    Name        = var.s3_bucket_name
    Environment = terraform.workspace
  }
}