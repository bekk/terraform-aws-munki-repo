resource "aws_acm_certificate" "cert" {
  domain_name       = "testing.example.com"
  validation_method = "EMAIL"

  validation_option {
    domain_name       = "testing.example.com"
    validation_domain = "example.com"
  }
}
