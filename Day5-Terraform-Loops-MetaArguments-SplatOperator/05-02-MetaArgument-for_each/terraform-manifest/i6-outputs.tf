# Terraform Output Values
# EC2 Instance Public IP with TOSET
output "for_each_toset_publicip" {
    description = "EC2 Instance Public IP"
    value       = toset([for i in aws_instance.myec2vm: i.public_ip])
}

# EC2 Instance Public DNS with TOSET
output "for_each_toset_publidns" {
    description = "EC2 Instance Public DNS"
    value       = toset([for i in aws_instance.myec2vm: i.public_dns])
}

# EC2 Instance Public DNS with TOMAP
output "tomap_ip_dns" {
  value         = tomap({for az,i in aws_instance.myec2vm: az => i.public_dns})
}


/*
# Additional Important Note about OUTPUTS when for_each used
1. The [*] and .* operators are intended for use with lists only. 
2. Because this resource uses for_each rather than count, 
its value in other expressions is a toset or a map, not a list.
3. With that said, we can use Function "toset" and loop with "for" 
to get the output for a list
4. For maps, we can directly use for loop to get the output and if we 
want to handle type conversion we can use "tomap" function too 
*/
