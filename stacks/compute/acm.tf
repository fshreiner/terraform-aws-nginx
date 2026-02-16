resource "aws_acm_certificate" "wildcard" {
  domain_name       = "*.fabioshreiner.com.br"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}