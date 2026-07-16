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



# Updated 
output "asg_build_resource_label" {
  value = "${module.nlb.arn_suffix}/${module.nlb.target_groups["mytg1"].arn_suffix}"
}