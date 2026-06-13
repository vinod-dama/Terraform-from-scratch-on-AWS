resource "aws_instance" "myec2vm" {
    ami = data.aws_ami.ami_id.id
    instance_type = var.instance_type
    key_name = var.key_name
    user_data = file("${path.module}/app1-install.sh")
    for_each = toset(keys({for az, i in data.aws_ec2_instance_type_offerings.available_types_yes_or_no: az => i.instance_types if length(i.instance_types) != 0 }))
    availability_zone = each.key
    vpc_security_group_ids = [ aws_security_group.vpc_ssh.id, aws_security_group.vpc_web.id ]
    tags = {
      "Name" = "Dynamic-ami-ec2-${each.key}" 
    }

}
