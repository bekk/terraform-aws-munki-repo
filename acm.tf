resource "aws_acm_certificate" "cert" {  
    domain_name = "${var.domain}"

    subject_alternative_names = ["*.${var.domain}"]
    validation_method = "EMAIL"
    lifecycle {
      create_before_destroy = true
    }
  }
