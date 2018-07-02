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

#
# ACM Certificate Validations
#

module "temperate_cert" {
  source = "github.com/azavea/terraform-aws-acm-certificate?ref=0.1.0"

  domain_name               = "${replace(var.temperate_r53_public_hosted_zone,"/.$/","")}"
  subject_alternative_names = ["*.${replace(var.temperate_r53_public_hosted_zone,"/.$/","")}"]
  hosted_zone_id            = "${aws_route53_zone.temperate.zone_id}"
  validation_record_ttl     = "60"
}

module "climate_cert" {
  source = "github.com/azavea/terraform-aws-acm-certificate?ref=0.1.0"

  domain_name               = "${replace(var.climate_r53_public_hosted_zone,"/.$/","")}"
  subject_alternative_names = ["*.${replace(var.climate_r53_public_hosted_zone,"/.$/","")}"]
  hosted_zone_id            = "${aws_route53_zone.external.zone_id}"
  validation_record_ttl     = "60"
}
