resource "aws_acm_certificate" "munkicert" {
  domain_name       = var.cloudfront_aliases
  validation_method = "EMAIL"

  validation_option {
    domain_name       = var.cloudfront_aliases
    validation_domain = "bekk.no"
  }
}
