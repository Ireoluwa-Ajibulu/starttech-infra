output "app_log_group_name" {
  description = "Name of the application log group"
  value       = aws_cloudwatch_log_group.app.name
}

output "frontend_log_group_name" {
  description = "Name of the frontend log group"
  value       = aws_cloudwatch_log_group.frontend.name
}

output "dashboard_name" {
  description = "Name of the CloudWatch dashboard"
  value       = aws_cloudwatch_dashboard.main.dashboard_name
}
