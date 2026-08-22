# Autoscaling Notifications
## AWS Bug for SNS Topic: https://stackoverflow.com/questions/62694223/cloudwatch-alarm-pending-confirmation
## Due to that create SNS Topic with unique name

## SNS - Topic
resource "aws_sns_topic" "myasg_sns_topic" {
  name = "${local.name}-${random_pet.this.id}"

  # arn is an exported attribute
}

## SNS - Subscription
resource "aws_sns_topic_subscription" "myasg_sns_topic_subscription" {
  topic_arn = aws_sns_topic.myasg_sns_topic.arn
  protocol  = "email"
  endpoint  = "vinod.dama@gmail.com"
}

resource "aws_autoscaling_notification" "example_notifications" {
  group_names = [
    aws_autoscaling_group.my-asg.id
  ]

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  topic_arn = aws_sns_topic.myasg_sns_topic.arn
}


