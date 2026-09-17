# Monitoring for the web server: alerts on high CPU and on the instance
# failing AWS's own status checks (a strong signal something is actually down).

resource "aws_sns_topic" "alerts" {
  name = "${var.project_name}-alerts"
}

resource "aws_sns_topic_subscription" "email_alert" {
  count     = var.alert_email != "" ? 1 : 0
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "${var.project_name}-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods   = 2
  metric_name          = "CPUUtilization"
  namespace            = "AWS/EC2"
  period               = 300
  statistic            = "Average"
  threshold            = 80
  alarm_description    = "Triggers when average CPU exceeds 80% for 10 minutes"
  alarm_actions        = [aws_sns_topic.alerts.arn]
  ok_actions            = [aws_sns_topic.alerts.arn]

  dimensions = {
    InstanceId = aws_instance.web.id
  }
}

resource "aws_cloudwatch_metric_alarm" "status_check_failed" {
  alarm_name          = "${var.project_name}-status-check-failed"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods   = 1
  metric_name          = "StatusCheckFailed"
  namespace            = "AWS/EC2"
  period               = 60
  statistic            = "Maximum"
  threshold            = 0
  alarm_description    = "Triggers if the instance fails an AWS status check (instance or system level)"
  alarm_actions        = [aws_sns_topic.alerts.arn]

  dimensions = {
    InstanceId = aws_instance.web.id
  }
}
