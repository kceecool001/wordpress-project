# CodeDeploy Application
resource "aws_codedeploy_app" "main" {
  name             = "${var.project}-${var.env}-app"
  compute_platform = "Server"
}

# CodeDeploy Deployment Group
resource "aws_codedeploy_deployment_group" "main" {
  app_name              = aws_codedeploy_app.main.name
  deployment_group_name = "${var.project}-${var.env}-dg"
  service_role_arn      = var.codedeploy_role_arn

  deployment_config_name = "CodeDeployDefault.AllAtOnce"

  # Target EC2 instances by tag
  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      type  = "KEY_AND_VALUE"
      value = "${var.project}-${var.env}-ec2"
    }
  }

  # Attach ALB target group for traffic routing
  load_balancer_info {
    target_group_info {
      name = var.target_group_name
    }
  }
}
