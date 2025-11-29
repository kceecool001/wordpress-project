output "ec2_instance_profile" {
  description = "IAM instance profile for EC2"
  value       = aws_iam_instance_profile.ec2_profile.name
}

#output "codedeploy_role_arn" {
#  description = "IAM role ARN for CodeDeploy"
#  value       = aws_iam_role.codedeploy_role.arn
#}
