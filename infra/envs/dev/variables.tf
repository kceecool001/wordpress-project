variable "region" {
  type        = string
  description = "AWS region"
  default     = "eu-central-1"
}
variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
  default     = "wordpress-project"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b"]
}
variable "env" {
  type = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.small"
}
variable "expiration_days" {
  description = "Days before objects expire in lifecycle policy"
  type        = number
  default     = 30
}