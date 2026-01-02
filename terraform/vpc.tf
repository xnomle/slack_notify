module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.21.0"

  name = "home-lab"
  cidr = "10.0.0.0/16"

  azs             = ["ap-southeast-2a", "ap-southeast-2b"]
  public_subnets  = ["10.0.100.0/24", "10.0.101.0/24"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
}