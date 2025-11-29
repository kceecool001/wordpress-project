terraform {
  backend "s3" {}
}
module "vpc"        { source = "../../modules/vpc" }
module "ec2"        { source = "../../modules/ec2" }
module "rds"        { source = "../../modules/rds" }
module "alb"        { source = "../../modules/alb" }
module "s3"         { source = "../../modules/s3" }
module "codedeploy" { source = "../../modules/codedeploy" }
module "iam"        { source = "../../modules/iam" }
