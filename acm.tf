resource "aws_acm_certificate" "cert" {  
    domain_name = "${var.cloudfront_aliases}"

    validation_method = "EMAIL"
    lifecycle {
      create_before_destroy = true
    }
  }
