provider "aws" {
    region = "us-east-1"
}

resource "aws_s3_bucket" "dcolanderjr_resume" {
    bucket = "kloudkamp.com"
    
    tags = {
        Name = "dcolanderjr_resume"
        Environment = "Prod"
        Team = "DevOps"
        Application = "Resume Website"
        Terraform = "True"
        Owner = "dcolanderjr@kloudkamp.com"
    }
}

resource "aws_s3_bucket_versioning" "dcolanderjr_resume" {
    bucket = "kloudkamp.com"
    versioning_configuration {
        status = "Enabled"
    }
}

resource "aws_s3_bucket_public_access_block" "dcolanderjr_resume" {
    bucket = "kloudkamp.com"

    block_public_acls = false
    restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "dcolanderjr_resume" {
    bucket = "kloudkamp.com"
    index_document {
        suffix = "index.html"
    }
}
