terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# AWS Provider
provider "aws" {
  region = "ap-southeast-2"
  default_tags {
    tags = {
      "project"    = "slack-notify"
      "terraform"  = "true"
      "test_infra" = "true"
    }
  }
}