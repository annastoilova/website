variable "aws_s3_bucket_prefix" { }

locals {
  aws_s3_bucket_frontend  = "${var.aws_s3_bucket_prefix}-frontend"
  aws_s3_bucket_backend   = "${var.aws_s3_bucket_prefix}-backend"
}

resource "aws_s3_bucket" "frontend" {
  bucket = local.aws_s3_bucket_frontend

  tags = {
    Environment = local.global_tag_environment
    Service     = local.global_tag_service
  }

  website {
    index_document = "index.html"
    error_document = "404.html"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "frontend_off" {
  bucket = aws_s3_bucket.frontend.bucket
  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "frontend" {
  bucket = aws_s3_bucket_public_access_block.frontend_off.bucket
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Sid": "PublicReadGetObject",
          "Effect": "Allow",
          "Principal": "*",
          "Action": "s3:GetObject",
          "Resource": "arn:aws:s3:::${aws_s3_bucket.frontend.bucket}/*"
      }
  ]
}
EOF
}

resource "aws_s3_bucket_public_access_block" "frontend_on" {
  bucket = aws_s3_bucket_policy.frontend.bucket
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = false
}

resource "aws_s3_bucket_metric" "frontend" {
  bucket = aws_s3_bucket.frontend.bucket
  name   = "EntireBucket"
}

resource "aws_s3_bucket" "backend" {
  bucket = local.aws_s3_bucket_backend

  tags = {
    Environment = local.global_tag_environment
    Service     = local.global_tag_service
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

output "s3_website" {
  value = aws_s3_bucket.frontend.website_endpoint
}
