#
# Private DNS resources
#
resource "aws_route53_zone" "internal" {
  name       = "${var.climate_r53_private_hosted_zone}"
  vpc_id     = "${module.vpc.id}"
  vpc_region = "${var.aws_region}"

  tags {
    Project     = "${var.project}"
    Environment = "${var.environment}"
  }
}

resource "aws_route53_record" "database" {
  zone_id = "${aws_route53_zone.internal.zone_id}"
  name    = "database.service.${var.climate_r53_private_hosted_zone}"
  type    = "CNAME"
  ttl     = "10"
  records = ["${module.database.hostname}"]
}

resource "aws_route53_record" "cache" {
  zone_id = "${aws_route53_zone.internal.zone_id}"
  name    = "cache.service.${var.climate_r53_private_hosted_zone}"
  type    = "CNAME"
  ttl     = "10"
  records = ["${module.cache.endpoint}"]
}

#
# Public DNS resources
#
resource "aws_route53_zone" "external" {
  name = "${var.climate_r53_public_hosted_zone}"
}

resource "aws_route53_record" "bastion" {
  zone_id = "${aws_route53_zone.external.zone_id}"
  name    = "bastion.${var.climate_r53_public_hosted_zone}"
  type    = "CNAME"
  ttl     = "300"
  records = ["${module.vpc.bastion_hostname}"]
}

resource "aws_route53_zone" "temperate" {
  name = "${var.temperate_r53_public_hosted_zone}"
}
