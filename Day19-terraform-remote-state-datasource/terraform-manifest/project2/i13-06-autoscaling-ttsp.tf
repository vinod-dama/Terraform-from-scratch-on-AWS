resource "aws_autoscaling_policy" "cpu-utilization-tacking-policy" {
  autoscaling_group_name    = aws_autoscaling_group.my_asg.id
  name                      = "cpu-utilization-tacking-policy"
  policy_type               = "TargetTrackingScaling"
  estimated_instance_warmup = 180

  target_tracking_configuration {
    target_value = 50
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"

    }
  }
}

resource "aws_autoscaling_policy" "alb_target_requests_greater_than_yy" {
  autoscaling_group_name    = aws_autoscaling_group.my_asg.id
  name                      = "alb-target-requests-greater-than-yy"
  policy_type               = "TargetTrackingScaling"
  estimated_instance_warmup = 120

  target_tracking_configuration {
    target_value = 50
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label         = "${module.alb.arn_suffix}/${module.alb.target_groups["mytg1"].arn_suffix}"
    }
  }
}



# Updated 
output "asg_build_resource_label" {
  value = "${module.alb.arn_suffix}/${module.alb.target_groups["mytg1"].arn_suffix}"
}