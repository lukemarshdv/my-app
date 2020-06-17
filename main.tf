# Require TF version to be same as or greater than 0.12.19
terraform {
  required_version = ">=0.12.19"
  /*
  backend "s3" {
    bucket         = "travis-ci-bootstrap-s3-kyler"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "aws-locks"
    encrypt        = true
  }
*/
}

# Download AWS provider
provider "aws" {
  region  = "us-east-1"
  version = "~> 2.36.0"
}


# Build a VPC
resource "aws_vpc" "aws_vpc" {
  cidr_block = "10.50.0.0/16"
  tags = {
    Name = "TravisCiVpc"
  }
}
# Adding subnet
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.aws_vpc.id
  cidr_block = "10.50.1.0/24"
  tags = {
    Name = "TravisCiCreatedSubnet"
  }
}
