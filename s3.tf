resource "aws_s3_bucket" "bekk-munki-www" {
  bucket = "${var.prefix}-${var.munki_s3_bucket}"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "www-encryption" {
  bucket = aws_s3_bucket.bekk-munki-www.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket" "bekk-munki-log-bucket" {
  bucket = "${var.prefix}-${var.munki_s3_bucket}-logs"
}

resource "aws_s3_bucket_acl" "www-acl" {
  bucket = aws_s3_bucket.bekk-munki-www.id
  acl = "private"
}
data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.bekk-munki-www.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.bekk-munki-www.arn]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "www" {
  bucket = aws_s3_bucket.bekk-munki-www.id
  policy = data.aws_iam_policy_document.s3_policy.json
}

resource "aws_s3_bucket_acl" "log_bucket_acl" {
  bucket = aws_s3_bucket.bekk-munki-log-bucket.id
  acl = "log-delivery-write"
}

resource "aws_s3_bucket_lifecycle_configuration" "log-lifecycle" {
  bucket = aws_s3_bucket.bekk-munki-log-bucket.id
  rule {
    id = "rule-1"
    
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
  }
}
resource "aws_s3_bucket_logging" "log_bucket" {
  bucket = aws_s3_bucket.bekk-munki-www.id
  target_bucket = aws_s3_bucket.bekk-munki-log-bucket.id
  target_prefix = "log/"
}
