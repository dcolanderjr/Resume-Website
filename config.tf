# Allows terraform to pull from a module in order to load the locals file up to S3.
terraform {
  required_version = "= 1.5.2"
}

provider "aws" {
    region = "us-east-1"
}

module "locals" {
    source = "./locals"
}
