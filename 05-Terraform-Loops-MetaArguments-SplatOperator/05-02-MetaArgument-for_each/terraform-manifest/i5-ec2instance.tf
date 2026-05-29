data "aws_availability_zones" "my_azones" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

resource "aws_instance" "myec2vm" {
    ami = data.aws_ami.ami_id.id
    instance_type = var.instance_type
    key_name = var.key_name
    user_data = file("${path.module}/app1-install.sh")
    for_each = toset(data.aws_availability_zones.my_azones.names)
    availability_zone = each.key
    vpc_security_group_ids = [ aws_security_group.vpc_ssh.id, aws_security_group.vpc_web.id ]
    tags = {
      "Name" = "Dynamic-ami-ec2-${each.value}" 
    }

}
