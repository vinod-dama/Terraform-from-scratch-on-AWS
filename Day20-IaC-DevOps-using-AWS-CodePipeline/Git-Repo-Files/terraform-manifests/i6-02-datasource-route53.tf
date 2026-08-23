data "aws_route53_zone" "website" {
  name = "vinodnayan.academy"

}


output "website_zone_id" {
  description = "The Hosted Zone id of the desired Hosted Zone"
  value       = data.aws_route53_zone.website.zone_id
}

output "website_zone_name" {
  description = "The Hosted Zone id of the desired Hosted Zone"
  value       = data.aws_route53_zone.website.name
}