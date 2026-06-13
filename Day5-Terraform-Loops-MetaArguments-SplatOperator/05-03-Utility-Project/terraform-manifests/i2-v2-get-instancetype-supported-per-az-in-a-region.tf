
#Datasource
data "aws_ec2_instance_type_offerings" "available_types_yes_or_no_1" {
    for_each = toset([ "us-east-1a", "us-east-1c", "us-east-1e" ])
    filter {
        name   = "instance-type"
        values = ["t3.micro"]
    }

    filter {
        name   = "location"
        values = [each.key]
    }

    location_type  = "availability-zone"
}

#output
output "v2_1" {
  value = toset([for i in data.aws_ec2_instance_type_offerings.available_types_yes_or_no_1: i.instance_types])  

}

#output
output "v2_2" {
  value = { for az, i in data.aws_ec2_instance_type_offerings.available_types_yes_or_no_1: az => i.instance_types }

}


