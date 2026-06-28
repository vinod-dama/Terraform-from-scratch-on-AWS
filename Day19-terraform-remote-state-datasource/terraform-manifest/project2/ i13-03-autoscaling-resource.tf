resource "aws_autoscaling_group" "my_asg" {
  name             = "my-asg"
  desired_capacity = 2
  max_size         = 10
  min_size         = 2

  health_check_grace_period = 300

  vpc_zone_identifier = data.terraform_remote_state.vpc.outputs.private_subnets
  target_group_arns   = [module.alb.target_groups["mytg1"].arn]
  health_check_type   = "EC2"
  launch_template {
    id      = aws_launch_template.my_launch_template.id
    version = aws_launch_template.my_launch_template.latest_version
  }

  tag {
    key                 = "alb-asg"
    value               = "Ec2-instances"
    propagate_at_launch = true
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }
}


