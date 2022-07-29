resource "aws_acm_certificate" "cert" {  
    domain_name = "${var.domain}"

    subject_alternative_names = ["*.${var.domain}"]
    validation_method = "EMAIL"
    ssl_support_method = "sni-only"
    lifecycle {
      create_before_destroy = true
    }
  }
