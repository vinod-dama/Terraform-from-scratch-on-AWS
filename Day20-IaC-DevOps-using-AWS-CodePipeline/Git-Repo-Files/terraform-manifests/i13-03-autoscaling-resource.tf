resource "aws_autoscaling_group" "my-asg" {
  name                      = "myasg-${local.name}"
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 120
  health_check_type         = "EC2"
  desired_capacity          = 2
  vpc_zone_identifier       = module.vpc.private_subnets
  target_group_arns         = module.alb.target_groups["mytg1"].arn

  launch_template {
    id      = aws_launch_template.my-launch-template.id
    version = aws_launch_template.my-launch-template.latest_version
  }
  
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["desired_capacity"]
  }

  tag {
    key                 = "owners"
    value               = "AI-DevOps"
    propagate_at_launch = false
  }
}