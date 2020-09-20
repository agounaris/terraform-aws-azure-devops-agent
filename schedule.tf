resource "aws_autoscaling_schedule" "scale_down_for_night" {
  scheduled_action_name  = "scale_down_for_night"
  autoscaling_group_name = "${aws_autoscaling_group.default.name}"

  min_size         = 0
  max_size         = 0
  desired_capacity = 0
  recurrence       = "0 21 * * MON-FRI"
}

resource "aws_autoscaling_schedule" "scale_up_for_work_day" {
  scheduled_action_name  = "scale_up_for_work_day"
  autoscaling_group_name = "${aws_autoscaling_group.default.name}"

  max_size         = "4"
  min_size         = "1"
  desired_capacity = "1"
  recurrence       = "0 6 * * MON-FRI"
}
