
#Datasource
data "aws_ec2_instance_type_offerings" "available_types_yes_or_no" {

    filter {
        name   = "instance-type"
        values = ["t3.micro"]
    }

    filter {
        name   = "location"
        values = ["us-east-1a"]
    }

    location_type  = "availability-zone"
}

#output
output "v1_1" {
  value = data.aws_ec2_instance_type_offerings.available_types_yes_or_no.instance_types
}



