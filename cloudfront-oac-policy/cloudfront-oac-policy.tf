
# This creates the S3 bucket policy that allows your website to be publicly viewable by others on the internet.
# Instead of manually creating it in the console, we will use Terraform to inject the policy. The policy will only allow
# traffic from the CloudFront distribution.

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = "www.kloudkamp.com"

  policy = jsonencode(
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Sid": "AllowCloudFrontServicePrincipalReadOnly",
          "Effect": "Allow",
          "Principal": {
            "Service": "cloudfront.amazonaws.com"
          },
          "Action": "s3:GetObject",
          "Resource": "arn:aws:s3:::www.kloudkamp.com/*",
          "Condition": {
            "StringEquals": {
              "AWS:SourceArn": "arn:aws:cloudfront::741890680366:distribution/E28WM3IYPPNP8T"
            }
          }
        }
      ]
    }
  )
}