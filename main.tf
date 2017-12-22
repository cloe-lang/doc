variable "domain" {}

provider "aws" {
  region = "us-east-1"
}

data "aws_acm_certificate" "c" {
  domain = "${var.domain}"
}

resource "aws_s3_bucket" "b" {
  bucket = "${var.domain}"
  acl    = "public-read"
}

resource "aws_cloudfront_distribution" "d" {
  aliases = ["${var.domain}", "www.${var.domain}"]

  origin {
    domain_name = "${aws_s3_bucket.b.bucket_domain_name}"
    origin_id   = "${aws_s3_bucket.b.id}"
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${aws_s3_bucket.b.id}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = "${data.aws_acm_certificate.c.arn}"
    ssl_support_method  = "sni-only"
  }
}

resource "aws_route53_zone" "z" {
  name = "${var.domain}"
}

resource "aws_route53_record" "root" {
  zone_id = "${aws_route53_zone.z.zone_id}"
  name    = "${var.domain}"
  type    = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.d.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.d.hosted_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www" {
  zone_id = "${aws_route53_zone.z.zone_id}"
  name    = "www.${var.domain}"
  type    = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.d.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.d.hosted_zone_id}"
    evaluate_target_health = false
  }
}

output "bucket" {
  value = "${aws_s3_bucket.b.id}"
}

output "name_servers" {
  value = "${aws_route53_zone.z.name_servers}"
}
