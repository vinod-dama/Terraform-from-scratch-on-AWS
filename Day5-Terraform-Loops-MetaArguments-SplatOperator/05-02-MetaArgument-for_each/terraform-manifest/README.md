# Terraform for_each Meta-Argument with Functions toset, tomap
Step-00: Pre-requisite Note
We are using the default vpc in us-east-1 region
Step-01: Introduction
for_each Meta-Argument
toset function
tomap function
Data Source: aws_availability_zones
Step-02: No changes to files
i1-versions.tf
i2-variables.tf
i3-ec2securitygroups.tf
i4-ami-datasource.tf
Step-03: i5-ec2instance.tf
To understand more about for_each
Step-03-01: Availability Zones Datasource
# Availability Zones Datasource
data "aws_availability_zones" "my_azones" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}
Step-03-02: EC2 Instance Resource
# EC2 Instance
resource "aws_instance" "myec2vm" {
    ami                    = data.aws_ami.ami_id.id
    instance_type          = var.instance_type
    key_name               = var.key_name
    user_data              = file("${path.module}/app1-install.sh")
    for_each               = toset(data.aws_availability_zones.my_azones.names)
    availability_zone      = each.key
    vpc_security_group_ids = [ aws_security_group.vpc_ssh.id, aws_security_group.vpc_web.id ]
    tags = {
      "Name"  = "Dynamic-ami-ec2-${each.value}" 
    }

}

Step-04: i6-outputs.tf
# EC2 Instance Public IP with TOSET
output "instance_publicip" {
  description = "EC2 Instance Public IP"
  #value = aws_instance.myec2vm.*.public_ip   # Legacy Splat
  #value = aws_instance.myec2vm[*].public_ip  # Latest Splat
  value = toset([
      for i in aws_instance.myec2vm: i.public_ip])
    ])  
}

# EC2 Instance Public DNS with TOSET
output "instance_publicdns" {
  description = "EC2 Instance Public DNS"
  #value = aws_instance.myec2vm[*].public_dns  # Legacy Splat
  #value = aws_instance.myec2vm[*].public_dns  # Latest Splat
  value = toset([
      for i in aws_instance.myec2vm: i.public_dns])
    ])    
}

# EC2 Instance Public DNS with MAPS
output "instance_publicdns2" {
  value = tomap({
    for az,i in aws_instance.myec2vm: az => i.public_dns
    # az intends to be a subnet ID
  })
}
Step-05: Execute Terraform Commands
# Terraform Initialize
terraform init

# Terraform Validate
terraform validate

# Terraform Plan
terraform plan

# Terraform Apply
terraform apply -auto-approve
Observations: 
1) Should fail with not creating EC2 Instance in 1 availability zone in region us-east-1
2) We will learn about fixing this in next two sections 05-03 and 05-04
3) Outputs not displayed as we failed during terraform apply. We will see and review outputs in section 05-04
Step-06: Expected Error Message
Error: Error launching source instance: Unsupported: Your requested instance type (t3.micro) is not supported in your requested Availability Zone (us-east-1e). Please retry your request by not specifying an Availability Zone or choosing us-east-1a, us-east-1b, us-east-1c, us-east-1d, us-east-1f.
	status code: 400, request id: 52e0e358-17a0-434b-80de-5bc5f956eedb

  on i5-ec2instance.tf line 35, in resource "aws_instance" "myec2vm":
  35: resource "aws_instance" "myec2vm" {
Step-07: Clean-Up
# Terraform Destroy
terraform destroy -auto-approve

# Clean-Up
rm -rf .terraform*
rm -rf terraform.tfstate*
References
Terraform Functions
Data Source: aws_availability_zones
for_each Meta-Argument
tomap Function
toset Function