# Creates the CloudFront Distribution.

resource "aws_cloudfront_distribution" "cloudfront_distribution" {
    enabled = true
  origin {
    domain_name = aws_s3_bucket.bucket_name.bucket_regional_domain_name
    origin_id   = "kloudkamp-s3-origin"
  }

# Enables IPV6, sets the default root object to index.html and sets the aliases to kloudkamp.com and www.kloudkamp.com.
    is_ipv6_enabled = true
    default_root_object = "index.html"
    aliases = ["www.kloudkamp.com", "kloudkamp.com"]

# Explains the default caching behavior of the distribution.
  default_cache_behavior {
      viewer_protocol_policy = "redirect-to-https"
      compress = true
      allowed_methods = ["GET", "HEAD", "OPTIONS"]
      cached_methods = ["GET", "HEAD", "OPTIONS"]
      target_origin_id = "kloudkamp-s3-origin"

# Since this is a simple website, no fancy forwarding or cookie values are needed.
  forwarded_values {
    query_string = false

    cookies {
      forward = "none"
    }
  }
}

# If we were to configure a geo-restriction policy, we would do it here.
  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

# Sets the viewer certificate to an ACM certificate; allows SSL/TLS connection.
  viewer_certificate {
    acm_certificate_arn = "arn:aws:acm:us-east-1:741890680366:certificate/551ad8f0-5ced-4646-bebf-71052db3167c"
    ssl_support_method  = "sni-only"
  }
}