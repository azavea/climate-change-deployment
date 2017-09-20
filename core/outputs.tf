output "aws_account_id" {
  value = "${var.aws_account_id}"
}

output "vpc_id" {
  value = "${module.vpc.id}"
}

output "public_subnet_ids" {
  value = "${module.vpc.public_subnet_ids}"
}

output "private_subnet_ids" {
  value = "${module.vpc.private_subnet_ids}"
}

output "nat_gateway_ips" {
  value = "${module.vpc.nat_gateway_ips}"
}

output "public_hosted_zone_id" {
  value = "${aws_route53_zone.external.id}"
}

output "container_service_cluster_id" {
  value = "${module.container_service_cluster.id}"
}

output "container_service_cluster_name" {
  value = "${module.container_service_cluster.name}"
}

output "container_service_cluster_ecs_service_role_name" {
  value = "${module.container_service_cluster.ecs_service_role_name}"
}

output "container_instance_security_group_id" {
  value = "${module.container_service_cluster.container_instance_security_group_id}"
}

output "rds_host" {
  value = "${aws_route53_record.database.fqdn}"
}

output "rds_database_name" {
  value = "${var.rds_database_name}"
}

output "rds_username" {
  value = "${var.rds_database_username}"
}

output "rds_password" {
  value = "${var.rds_database_password}"
}

output "ec_memcached_host" {
  value = "${aws_route53_record.cache.fqdn}"
}

output "ec_memcached_port" {
  value = "${module.cache.port}"
}

output "s3_storage_bucket" {
  value = "${aws_s3_bucket.static.id}"
}

output "sqs_queue_name" {
  value = "${var.sqs_queue_name}"
}

output "papertrail_host" {
  value = "${var.papertrail_host}"
}

output "papertrail_port" {
  value = "${var.papertrail_port}"
}
