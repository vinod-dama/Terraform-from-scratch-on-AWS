# DNS Registration 
resource "aws_route53_record" "apps_dns" {
  zone_id = data.aws_route53_zone.website.zone_id 
  name    = "myapps.vinodnayan.academy"
  type    = "A"
  alias {
    name                   = module.alb.dns_name
    zone_id                = module.alb.zone_id
    evaluate_target_health = true
  }  
}

## Testing Host Header - Redirect to External Site from ALB HTTPS Listener Rules
resource "aws_route53_record" "app1_dns" {
  zone_id = data.aws_route53_zone.website.zone_id 
  name    = "videos.vinodnayan.academy"
  type    = "A"
  alias {
    name                   = module.alb.dns_name
    zone_id                = module.alb.zone_id
    evaluate_target_health = true
  }  
}