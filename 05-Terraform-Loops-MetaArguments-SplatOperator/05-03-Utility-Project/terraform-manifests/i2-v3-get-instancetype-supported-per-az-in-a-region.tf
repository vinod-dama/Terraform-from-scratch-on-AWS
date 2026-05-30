
#Datasource

data "aws_availability_zones" "my_azones" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}


data "aws_ec2_instance_type_offerings" "available_types_yes_or_no_2" {
    for_each = toset(data.aws_availability_zones.my_azones.names)
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
output "v3_1" {
    value = {for az, i in data.aws_ec2_instance_type_offerings.available_types_yes_or_no_2: az => i.instance_types}
  
}

output "v3_2" {
    value = {for az, i in data.aws_ec2_instance_type_offerings.available_types_yes_or_no_2: az => i.instance_types if length(i.instance_types) != 0 }
  
}

output "v3_3" {
    value = keys({for az, i in data.aws_ec2_instance_type_offerings.available_types_yes_or_no_2: az => i.instance_types if length(i.instance_types) != 0 })
  
}

output "v3_4" {
    value = keys({for az, i in data.aws_ec2_instance_type_offerings.available_types_yes_or_no_2: az => i.instance_types if length(i.instance_types) != 0 })[0]
  
}







