# Provider for Terraform, AWS, and working region
provider "aws" {
    region = "us-east-1"
}

# Create bucket, and add desired tags(optional). For hosting a static website on S3, you must use the format xxx.com, or whatever
# you want to call your website. I am using kloudkamp.com for this example, which I registered in Route53.
resource "aws_s3_bucket" "dcolanderjr_resume" {
    bucket = "kloudkamp.com"
    
    tags = {
        Name = "dcolanderjr_resume"
        Environment = "Prod"
        Application = "Resume Website"
        Terraform = "True"
        Owner = "dcolanderjr@kloudkamp.com"
    }
}

# This enables versioning on the bucket, so that you can keep track of changes to your website as it changes.
resource "aws_s3_bucket_versioning" "dcolanderjr_resume" {
    bucket = "kloudkamp.com"
    versioning_configuration {
        status = "Enabled"
    }
}

# This enables the bucket to be publically accessible, so that your website can be viewed from the internet.
resource "aws_s3_bucket_public_access_block" "dcolanderjr_resume" {
    bucket = "kloudkamp.com"

    block_public_acls = false
    restrict_public_buckets = false
}

# This enables the "Static Website Hosting" option that is under the permissions in the S3 Console. The index.html
# refers to your index.html file in the root directory of your website.
resource "aws_s3_bucket_website_configuration" "dcolanderjr_resume" {
    bucket = "kloudkamp.com"
    index_document {
        suffix = "index.html"
    }
}

# This creates the S3 bucket policy that allows your website to be publicly viewable by others on the internet.
# Instead of manually creating it in the console, we will use Terraform to inject the policy.
resource "aws_s3_bucket_policy" "dcolanderjr_resume" {
  bucket = "kloudkamp.com"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "PublicReadGetObject",
          "Effect" : "Allow",
          "Principal" : "*",
          "Action" : "s3:GetObject",
          "Resource" : "arn:aws:s3:::kloudkamp.com/*"
        }
      ]
    }
  )
}

resource "aws_s3_object" "file" {
    for_each = fileset(path.locals, "Websitefiles/*.{html,css,js}")
    bucket = "kloudkamp.com"
    key = replace(each.value, "/^Websitefiles/", "")
    source = each.value
    content_type = lookup(local.content_types, regex("\\.[^.]+$", each.value), null)
    etag = filemd5(each.value)
}