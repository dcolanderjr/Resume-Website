
# This creates the S3 bucket policy that allows your website to be publicly viewable by others on the internet.
# Instead of manually creating it in the console, we will use Terraform to inject the policy. The policy will only allow
# traffic from the CloudFront distribution.
resource "aws_s3_bucket" "bucket_name" {
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
resource "aws_s3_bucket_versioning" "versioning_suspended" {
    bucket = "www.kloudkamp.com"
    versioning_configuration {
        status = "Suspended"
    }
}

# This enables the bucket to be publically accessible, so that your website can be viewed from the internet.
resource "aws_s3_bucket_public_access_block" "public_access_enabled" {
    bucket = "www.kloudkamp.com"

    block_public_acls = false
    restrict_public_buckets = false
}

# This enables the "Static Website Hosting" option that is under the permissions in the S3 Console. The index.html
# refers to your index.html file in the root directory of your website.
resource "aws_s3_bucket_website_configuration" "website_config" {
    bucket = "www.kloudkamp.com"
    index_document {
        suffix = "index.html"
    }
}