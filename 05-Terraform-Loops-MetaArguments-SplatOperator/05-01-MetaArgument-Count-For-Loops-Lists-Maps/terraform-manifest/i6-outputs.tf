# Terraform Output Values
/* Concepts Covered
1. For Loop with List
2. For Loop with Map
3. For Loop with Map Advanced
4. Legacy Splat Operator (latest) - Returns List
5. Latest Generalized Splat Operator - Returns the List
*/

# Output - For Loop with List
output "for_list" {
    description = "list of values"
    value = [for i in aws_instance.myec2vm: i.public_dns]
}


# Output - For Loop with Map
output "for_map" {
    description = "map of values"
    value = {for i in aws_instance.myec2vm: i.id => i.public_dns}
  
}

# Output - For Loop with Map Advanced
output "for_map_advance" {
    description = "map of values advanced"
    value = {for i1, i2 in aws_instance.myec2vm: i1 => i2.public_dns}
  
}

# Output Latest Generalized Splat Operator - Returns the List
output "fo_map_splat" {
    description = "value"
    value = aws_instance.myec2vm[*].public_dns
  
}