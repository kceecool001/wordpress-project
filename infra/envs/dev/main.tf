terraform {
  backend "s3" {
    bucket  = "wordpress-project1483"
    key     = "wordpress/dev/terraform.tfstate"
    region  = "eu-central-1"
    encrypt = true
  }
}

module "vpc" {
  source          = "../../modules/vpc"
  project         = "wordpress-project"
  vpc_cidr        = "10.0.0.0/16"
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
  azs             = ["eu-central-1a", "eu-central-1b"]
}

module "ec2" {
  source               = "../../modules/ec2"
  project              = "wordpress-project"
  vpc_id               = module.vpc.vpc_id
  public_subnet_ids    = module.vpc.public_subnet_ids
  ami_id               = "ami-0a6793a25df710b06"
  instance_type        = "t3.small"
  key_name             = "devops"
  ssh_cidrs            = ["0.0.0.0/0"]
  iam_instance_profile = module.iam.ec2_instance_profile
}

module "rds" {
  source             = "../../modules/rds"
  project            = "wordpress-project"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  app_sg_ids         = [module.ec2.ec2_sg_id]

  db_engine         = "mysql"
  db_version        = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  db_username       = "admin"
  db_password       = "supersecret"
  multi_az          = false
}

module "alb" {
  source            = "../../modules/alb"
  project           = "wordpress-project"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  ec2_instance_ids  = [module.ec2.ec2_id]
  env               = "dev"
}

module "s3" {
  source          = "../../modules/s3"
  project         = "wordpress-project"
  env             = "dev"
  expiration_days = 30
}

module "iam" {
  source  = "../../modules/iam"
  project = var.project_name
  env     = var.env
}

resource "aws_lb_target_group_attachment" "ec2_attach" {
  target_group_arn = module.alb.target_group_arn
  target_id        = module.ec2.ec2_id
  port             = 80
}

#module "codedeploy" {
#  source              = "../../modules/codedeploy"
#  project             = var.project_name
#  env                 = var.env
#  codedeploy_role_arn = module.iam.codedeploy_role_arn
#  target_group_name   = module.alb.target_group_name
#}

