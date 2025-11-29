variable "project" {
  description = "Project name prefix"
  type        = string
}

variable "env" {
  description = "Environment name (dev/prod)"
  type        = string
}

variable "codedeploy_role_arn" {
  description = "IAM role ARN for CodeDeploy"
  type        = string
}

variable "target_group_name" {
  description = "ALB target group name"
  type        = string
}
