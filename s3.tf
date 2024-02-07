# Create bucket, and add desired tags(optional). For hosting a static website on S3, you must use the format xxx.com, or whatever
# you want to call your website. I am using www.kloudkamp.com for this example, which I registered in Route53.

# Provider for Terraform, AWS, and working region
provider "aws" {
    region = "us-east-1"
}

resource "aws_s3_bucket" "www.kloudkamp.com" {
    bucket = "www.kloudkamp.com"
    
    tags = {
        Name = "www.kloudkamp.com"
        Environment = "Prod"
        Application = "Resume Website"
        Terraform = "True"
        Owner = "dcolanderjr@kloudkamp.com"
    }
}

# This enables versioning on the bucket, so that you can keep track of changes to your website as it changes.
resource "aws_s3_bucket_versioning" "www.kloudkamp.com" {
    bucket = "www.kloudkamp.com"
    versioning_configuration {
        status = "Enabled"
    }
}

# This enables the bucket to be publically accessible, so that your website can be viewed from the internet.
resource "aws_s3_bucket_public_access_block" "www.kloudkamp.com" {
    bucket = "www.kloudkamp.com"

    block_public_acls = false
    restrict_public_buckets = false
}

# This enables the "Static Website Hosting" option that is under the permissions in the S3 Console. The index.html
# refers to your index.html file in the root directory of your website.
resource "aws_s3_bucket_website_configuration" "www.kloudkamp.com" {
    bucket = "www.kloudkamp.com"
    index_document {
        suffix = "index.html"
    }
}

# This creates the S3 bucket policy that allows your website to be publicly viewable by others on the internet.
# Instead of manually creating it in the console, we will use Terraform to inject the policy. The policy will only allow
# traffic from the CloudFront distribution.
resource "aws_s3_bucket_policy" "www.kloudkamp.com" {
  bucket = "www.kloudkamp.com"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "PublicReadGetObject",
          "Effect" : "Allow",
          "Principal" : "*",
          "Action" : "s3:GetObject",
          "Resource" : "arn:aws:s3:::www.kloudkamp.com/*"
        }
      ]
    }
  )
}

# This creates the S3 object resource. This piece of code is a little intricate, so I will try to
# sythesize it for you: the for_each instruction allows the content to be looped over all of the files
# in the Websitefiles directory. The replace instruction removes the Websitefiles prefix from the file name.
# The source instruction is the file path. The content_type instruction is a lookup table that maps file extensions
# to their content types. The etag instruction is the file's MD5 hash which is necessary for versioning, and caching.
# We will also be deploying a CloudFront distribution later, which will be in another file.
resource "aws_s3_object" "file" {
    for_each = fileset(path.locals, "Websitefiles/*.{html,css,js}")
    bucket = "www.kloudkamp.com"
    key = replace(each.value, "/^Websitefiles/", "")
    source = each.value
    content_type = lookup(local.content_types, regex("\\.[^.]+$", each.value), null)
    etag = filemd5(each.value)
}