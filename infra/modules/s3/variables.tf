variable "project" {
  description = "Project name prefix"
  type        = string
}

variable "env" {
  description = "Environment name (dev/prod)"
  type        = string
}

variable "expiration_days" {
  description = "Days before objects expire"
  type        = number
  default     = 30
}
