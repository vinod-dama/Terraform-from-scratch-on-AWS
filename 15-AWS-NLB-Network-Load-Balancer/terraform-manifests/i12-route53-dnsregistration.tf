# DNS Registration 
resource "aws_route53_record" "apps_dns" {
  zone_id = data.aws_route53_zone.website.zone_id
  name    = "myasg-NLB.vinodnayan.academy"
  type    = "A"
  alias {
    name                   = module.nlb.dns_name
    zone_id                = module.nlb.zone_id
    evaluate_target_health = true
  }
}

