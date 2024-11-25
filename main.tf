provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket = "diamond-git-codebuild-terraform"
    key = "terraform.tfstate"
    region = "eu-central-1"
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.16.0"

  name = "Diamond-VPC"
  cidr = "10.0.0.0/16"
  azs             = ["eu-central-1a"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  private_subnet_tags = {
    Name= "Diamond-Private-Subnet" 
  }

  public_subnet_tags = {
    Name= "Diamond-Public-Subnet" 
  }

  tags = {
    Owner = "Diamond" 
  }
}