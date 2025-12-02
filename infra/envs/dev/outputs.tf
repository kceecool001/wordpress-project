# VPC outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

# EC2 outputs
output "ec2_id" {
  description = "ID of the EC2 instance"
  value       = module.ec2.ec2_id
}

output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = module.ec2.ec2_public_ip
}

output "ec2_private_ip" {
  description = "Private IP of the EC2 instance"
  value       = module.ec2.ec2_private_ip
}

# RDS outputs
output "db_endpoint" {
  description = "RDS database endpoint"
  value       = module.rds.db_endpoint
}

output "db_port" {
  description = "RDS database port"
  value       = module.rds.db_port
}

# ALB outputs
output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = module.alb.alb_dns_name
}

output "alb_arn" {
  description = "ARN of the ALB"
  value       = module.alb.alb_arn
}
output "target_group_arn" {
  value = module.alb.target_group_arn
}

# S3 outputs (application bucket, not tfstate)
output "s3_bucket_name" {
  description = "Name of the S3 bucket for app assets/logs"
  value       = module.s3.bucket_name
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket for app assets/logs"
  value       = module.s3.bucket_arn
}
output "ec2_instance_profile" {
  description = "IAM instance profile for EC2"
  value       = module.iam.ec2_instance_profile
}

#output "codedeploy_role_arn" {
# description = "IAM role ARN for CodeDeploy"
## value       = module.iam.codedeploy_role_arn
#}