provider "aws" {
  region     = var.aws_region
  access_key = var.aws_key_name
  secret_key = var.aws_secret_key
}

terraform {
	required_providers {
		aws = {
	    version = "5.22.0"
		}
  }
}