# General purpose S3 bucket (e.g. for app assets, logs)
resource "aws_s3_bucket" "main" {
  bucket = "${var.project}-assets-${var.env}"

  tags = {
    Name        = "${var.project}-assets-${var.env}"
    Environment = var.env
  }
}

resource "aws_s3_bucket_ownership_controls" "main" {
  bucket = aws_s3_bucket.main.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# Enable versioning
resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.main.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Lifecycle rules 
resource "aws_s3_bucket_lifecycle_configuration" "main" {
  bucket = aws_s3_bucket.main.id

  rule {
    id     = "expire-old"
    status = "Enabled"

    expiration {
      days = var.expiration_days
    }
  }
}
