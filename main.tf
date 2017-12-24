variable "domain" {}
variable "google_site_verification" {}

variable "addresses" {
  type = "list"
}

variable "ttl" {
  default = 5
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_route53_zone" "z" {
  name = "${var.domain}"
}

resource "aws_route53_record" "txt" {
  zone_id = "${aws_route53_zone.z.zone_id}"
  name    = "${var.domain}"
  ttl     = "${var.ttl}"
  type    = "TXT"
  records = ["google-site-verification=${var.google_site_verification}"]
}

resource "aws_route53_record" "a" {
  zone_id = "${aws_route53_zone.z.zone_id}"
  name    = "${var.domain}"
  ttl     = "${var.ttl}"
  type    = "A"
  records = "${var.addresses}"
}

output "name_servers" {
  value = "${aws_route53_zone.z.name_servers}"
}
