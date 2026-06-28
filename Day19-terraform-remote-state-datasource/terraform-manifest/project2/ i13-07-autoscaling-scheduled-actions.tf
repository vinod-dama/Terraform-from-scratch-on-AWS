## Create Scheduled Actions
### Create Scheduled Action-1: Increase capacity during business hours
resource "aws_autoscaling_schedule" "increase_capacity_7am" {
  scheduled_action_name  = "increase-capacity-7am"
  min_size               = 2
  max_size               = 10
  desired_capacity       = 4
  start_time             = "2026-06-24T19:23:00Z" # Time should be provided in UTC Timezone (11am UTC = 7AM EST)
  recurrence             = "00 09 * * *"
  autoscaling_group_name = aws_autoscaling_group.my_asg.id
}


resource "aws_autoscaling_schedule" "decrease_capacity_7pm" {
  scheduled_action_name  = "decrease-capacity"
  min_size               = 1
  max_size               = 10
  desired_capacity       = 2
  start_time             = "2026-06-24T19:33:00Z" # Time should be provided in UTC Timezone (11am UTC = 7AM EST)
  recurrence             = "00 19 * * *"
  autoscaling_group_name = aws_autoscaling_group.my_asg.name
}