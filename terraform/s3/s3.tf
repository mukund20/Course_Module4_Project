terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "terraform-on-aws-for-ec2"
    key    = "dev/project1-vpc/terraform.tfstate"
    region = "us-east-1" 
   
  }    
}

# Provider Block
provider "aws" {
  region  = var.aws_region
  profile = "default"
}