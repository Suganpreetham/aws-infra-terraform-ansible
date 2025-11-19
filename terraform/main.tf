terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.3.0"
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"
  cidr   = var.vpc_cidr
}

module "web" {
  source             = "./modules/ec2"
  instance_count     = var.instance_count
  instance_type      = var.instance_type
  ami_id             = var.ami_id
  subnet_id          = module.vpc.public_subnet_id
  ssh_authorized_key = var.ssh_public_key
}

