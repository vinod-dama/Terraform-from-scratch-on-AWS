resource "aws_launch_template" "my_launch_template" {
  name = "my-launch-template"

  image_id               = data.aws_ami.ami_linux.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [module.private_sg.security_group_id]

  user_data              = filebase64("${path.module}/app1-install.sh")
  ebs_optimized          = true
  update_default_version = true
  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size           = 20
      delete_on_termination = true
      volume_type           = "gp2"
    }
  }


  monitoring {
    enabled = true
  }



  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "test"
    }
  }

}