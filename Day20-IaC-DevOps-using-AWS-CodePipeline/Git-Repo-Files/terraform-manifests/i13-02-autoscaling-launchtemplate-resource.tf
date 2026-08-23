resource "aws_launch_template" "my_launch_template" {
  name          = "my-launch-template-${local.name}"
  image_id      = data.aws_ami.ami_linux.id
  instance_type = var.instance_type
  key_name      = var.key_name
  ebs_optimized = true
  user_data     = filebase64("${path.module}/app1-install.sh")
  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size = 20
      volume_type = "gp2" # default is gp2
    }
  }

  vpc_security_group_ids = [module.private_sg.id]

  instance_initiated_shutdown_behavior = "terminate"

  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = local.name
    }
  }


}