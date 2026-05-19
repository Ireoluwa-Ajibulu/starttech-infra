variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment (dev, staging, production)"
  type        = string
}

variable "autoscaling_group_name" {
  description = "Name of the Auto Scaling Group"
  type        = string
}

variable "scale_up_policy_arn" {
  description = "ARN of the scale up policy"
  type        = string
}

variable "scale_down_policy_arn" {
  description = "ARN of the scale down policy"
  type        = string
}

variable "alb_arn" {
  description = "ARN of the Application Load Balancer"
  type        = string
}
