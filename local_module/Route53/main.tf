# create acm certificate
resource "aws_acm_certificate" "Hash_cert" {
  domain_name       = "adfimah.com"
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

data "aws_route53_zone" "Hash_r53_zone" {
  name         = "adfimah.com"
  private_zone = false
}

resource "aws_route53_record" "Hash_r53_record" {
  for_each = {
    for dvo in aws_acm_certificate.Hash_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.Hash_r53_zone.zone_id
}

# Validate acm certificate validation
resource "aws_acm_certificate_validation" "jas_cert_valdt" {
  certificate_arn         = aws_acm_certificate.Hash_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.Hash_r53_record : record.fqdn]
}

resource "aws_route53_record" "www" {
 zone_id         = data.aws_route53_zone.Hash_r53_zone.zone_id
  name    = "adfimah.com"
  type    = "A"

  alias {
    name                   = var.lb_DNS
    zone_id                = var.lb_zone_id
    evaluate_target_health = true
  }
}

