module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 5.0"

  domain_name       = data.aws_route53_zone.website.name
  zone_id           = data.aws_route53_zone.website.zone_id

  subject_alternative_names = [
    "*.vinodnayan.academy"
  ]

  validation_method = "DNS"
  wait_for_validation = true  

  tags = local.common_tags
}


# Output ACM Certificate ARN
output "acm_certificate_arn" {
  description = "The ARN of the certificate"
  # Module Upgrade Change-2  
  #value       = module.acm.this_acm_certificate_arn
  value       = module.acm.acm_certificate_arn
}
