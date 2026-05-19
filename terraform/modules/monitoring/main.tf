resource "aws_cloudwatch_log_group" "app" {
  name              = "${var.project_name}-app-logs"
  retention_in_days = 30

  tags = {
    Name        = "${var.project_name}-app-logs"
    Environment = var.environment
  }
}

resource "aws_cloudwatch_log_group" "frontend" {
  name              = "${var.project_name}-frontend-logs"
  retention_in_days = 30

  tags = {
    Name        = "${var.project_name}-frontend-logs"
    Environment = var.environment
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "${var.project_name}-cpu-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This metric monitors high CPU utilization"
  alarm_actions       = [var.scale_up_policy_arn]

  dimensions = {
    AutoScalingGroupName = var.autoscaling_group_name
  }

  tags = {
    Name        = "${var.project_name}-cpu-high-alarm"
    Environment = var.environment
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  alarm_name          = "${var.project_name}-cpu-low"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 20
  alarm_description   = "This metric monitors low CPU utilization"
  alarm_actions       = [var.scale_down_policy_arn]

  dimensions = {
    AutoScalingGroupName = var.autoscaling_group_name
  }

  tags = {
    Name        = "${var.project_name}-cpu-low-alarm"
    Environment = var.environment
  }
}

resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${var.project_name}-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/EC2", "CPUUtilization", "AutoScalingGroupName", var.autoscaling_group_name]
          ]
          period = 300
          title  = "EC2 CPU Utilization"
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/ApplicationELB", "RequestCount", "LoadBalancer", var.alb_arn]
          ]
          period = 300
          title  = "ALB Request Count"
        }
      }
    ]
  })
}
