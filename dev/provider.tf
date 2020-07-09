provider "aws" {
	region = "${var.aws_region}"
}

module "vpc" {
  source = "../modules/aws-vpc"
}

terraform {
  backend "s3" {
  }
}

