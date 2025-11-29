# EC2 Role
resource "aws_iam_role" "ec2_role" {
  name               = "${var.project}-${var.env}-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume.json
}

data "aws_iam_policy_document" "ec2_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# Attach S3 + CloudWatch policies to EC2 role
resource "aws_iam_role_policy_attachment" "ec2_s3" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "ec2_cw" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# Instance profile for EC2
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.project}-${var.env}-ec2-profile"
  role = aws_iam_role.ec2_role.name
}

# CodeDeploy Role
#resource "aws_iam_role" "codedeploy_role" {
#  name               = "${var.project}-${var.env}-codedeploy-role"
#  assume_role_policy = data.aws_iam_policy_document.codedeploy_assume.json
#}

#data "aws_iam_policy_document" "codedeploy_assume" {
#  statement {
#    actions = ["sts:AssumeRole"]
#    principals {
#      type        = "Service"
#      identifiers = ["codedeploy.amazonaws.com"]
#    }
#  }
#}

# Attach CodeDeploy policy
#resource "aws_iam_role_policy_attachment" "codedeploy_policy" {
#  role       = aws_iam_role.codedeploy_role.name
#  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
#}
