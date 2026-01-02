terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket         	   = "slack-notify-project-tfstate"
    key              	   = "state/terraform.tfstate"
    region         	   = "ap-southeast-2"
    use_lockfile = true
  }
}

# AWS Provider
provider "aws" {
  region = "ap-southeast-2"
  default_tags {
    tags = {
      "project"   = "slack-notify"
      "terraform" = "true"
    }
  }
}