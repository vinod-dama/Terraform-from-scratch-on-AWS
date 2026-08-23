module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  domain_name = trimsuffix(data.aws_route53_zone.website.name, ".")
  zone_id     = data.aws_route53_zone.website.zone_id

  validation_method   = "DNS"
  wait_for_validation = true

  subject_alternative_names = [
    var.dns_name
  ]

  tags = local.common_tags
}

# Output ACM Certificate ARN
output "this_acm_certificate_arn" {
  description = "The ARN of the certificate"
  #value       = module.acm.this_acm_certificate_arn
  value = module.acm.acm_certificate_arn
}