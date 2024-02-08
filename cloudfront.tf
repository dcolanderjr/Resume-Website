resource "aws_cloudfront_distribution" "cloudfront_distribution" {
    enabled = true

  origin {
    domain_name = aws_s3_bucket.bucket_name.bucket_regional_domain_name
    origin_id   = "kloudkamp-s3-origin"
  }

    is_ipv6_enabled = true
    default_root_object = "index.html"
    aliases = ["www.kloudkamp.com", "kloudkamp.com"]

  default_cache_behavior {
      viewer_protocol_policy = "redirect-to-https"
      compress = true
      allowed_methods = ["GET", "HEAD", "OPTIONS"]
      cached_methods = ["GET", "HEAD", "OPTIONS"]
      target_origin_id = "kloudkamp-s3-origin"

  forwarded_values {
    query_string = false

    cookies {
      forward = "none"
    }
  }
}

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  viewer_certificate {
    acm_certificate_arn = "arn:aws:acm:us-east-1:741890680366:certificate/551ad8f0-5ced-4646-bebf-71052db3167c"
    ssl_support_method  = "sni-only"
  }
}
