resource "aws_acm_certificate" "default" {
    provider = "aws.acm"  
    domain_name = "${var.domain}"

    subject_alternative_names = ["*.${var.domain}"]
    validation_method = "EMAIL"  lifecycle {
      create_before_destroy = true
    }
  }
