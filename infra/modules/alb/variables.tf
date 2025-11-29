variable "project" {
  description = "Project name prefix"
  type        = string
}

variable "env" {
  type = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "ec2_instance_ids" {
  description = "List of EC2 instance IDs to attach"
  type        = list(string)
}
