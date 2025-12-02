module "vpc" {
  source          = "./modules/vpc"
  project_name    = "EduTrack"
  environment     = "dev"
  vpc_cidr        = "10.0.0.0/16"
  azs             = ["us-east-1a", "us-east-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24", "10.0.7.0/24", "10.0.8.0/24"]
  enable_nat      = true
  extra_tags      = { Owner = "Team-SkyOps" }
}