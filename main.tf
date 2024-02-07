# Provider for Terraform, AWS, and working region
provider "aws" {
    region = "us-east-1"
}

module "s3bucket" {
    source = "s3bucket.tf"
}

module "locals" {
    source = "locals.tf"
}

module "cloudfront" {
    source = "cloudfront.tf"
}

