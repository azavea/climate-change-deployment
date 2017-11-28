variable "project" {
  default = "Climate Change"
}

variable "environment" {
  default = "Staging"
}

variable "aws_region" {
  default = "us-east-1"
}

variable "aws_availability_zones" {
  default = ["us-east-1a", "us-east-1c"]
}

variable "aws_account_id" {}

variable "aws_ecs_service_role_policy_arn" {
  default = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

variable "aws_cloudwatch_logs_policy_arn" {
  default = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

variable "aws_s3_policy_arn" {
  default = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

variable "aws_sqs_policy_arn" {
  default = "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
}

variable "aws_key_name" {}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "external_access_cidr_block" {
  default = "66.212.12.106/32"
}

variable "vpc_private_subnet_cidr_blocks" {
  default = ["10.0.1.0/24", "10.0.3.0/24"]
}

variable "vpc_public_subnet_cidr_blocks" {
  default = ["10.0.0.0/24", "10.0.2.0/24"]
}

variable "bastion_ami" {}

variable "bastion_instance_type" {}

variable "rds_allocated_storage" {
  default = "64"
}

variable "rds_engine_version" {
  default = "9.5.2"
}

variable "rds_parameter_group_family" {
  default = "postgres9.5"
}

variable "rds_instance_type" {
  default = "db.t2.micro"
}

variable "rds_storage_type" {
  default = "gp2"
}

variable "rds_database_identifier" {}

variable "rds_database_name" {}

variable "rds_database_username" {}

variable "rds_database_password" {}

variable "rds_backup_retention_period" {
  default = "30"
}

variable "rds_backup_window" {
  default = "04:00-04:30"
}

variable "rds_maintenance_window" {
  default = "sun:04:30-sun:05:30"
}

variable "rds_auto_minor_version_upgrade" {
  default = true
}

variable "rds_final_snapshot_identifier" {
  default = "raster-foundry-rds-snapshot"
}

variable "rds_skip_final_snapshot" {
  default = false
}

variable "rds_copy_tags_to_snapshot" {
  default = true
}

variable "rds_multi_az" {
  default = false
}

variable "rds_storage_encrypted" {
  default = false
}

variable "rds_cpu_threshold_percent" {
  default = "75"
}

variable "rds_disk_queue_threshold" {
  default = "10"
}

variable "rds_free_disk_threshold_bytes" {
  default = "5000000000"
}

variable "rds_free_memory_threshold_bytes" {
  default = "128000000"
}

variable "container_instance_type" {
  default = "t2.small"
}

variable "container_instance_root_block_device_type" {
  default = "gp2"
}

variable "container_instance_root_block_device_size" {
  default = "8"
}

variable "container_instance_asg_desired_capacity" {
  default = "2"
}

variable "container_instance_asg_max_size" {
  default = "2"
}

variable "container_instance_asg_min_size" {
  default = "1"
}

variable "container_instance_asg_scale_up_cooldown_seconds" {
  default = "90"
}

variable "container_instance_asg_scale_down_cooldown_seconds" {
  default = "900"
}

variable "container_instance_asg_high_cpu_evaluation_periods" {
  default = "1"
}

variable "container_instance_asg_high_cpu_period_seconds" {
  default = "60"
}

variable "container_instance_asg_high_cpu_threshold_percent" {
  default = "75"
}

variable "container_instance_asg_low_cpu_evaluation_periods" {
  default = "5"
}

variable "container_instance_asg_low_cpu_period_seconds" {
  default = "60"
}

variable "container_instance_asg_low_cpu_threshold_percent" {
  default = "50"
}

variable "container_instance_asg_high_memory_evaluation_periods" {
  default = "1"
}

variable "container_instance_asg_high_memory_period_seconds" {
  default = "60"
}

variable "container_instance_asg_high_memory_threshold_percent" {
  default = "75"
}

variable "container_instance_asg_low_memory_evaluation_periods" {
  default = "5"
}

variable "container_instance_asg_low_memory_period_seconds" {
  default = "60"
}

variable "container_instance_asg_low_memory_threshold_percent" {
  default = "50"
}

variable "ec_memcached_identifier" {}

variable "ec_memcached_parameter_group_family" {
  default = "memcached1.4"
}

variable "ec_memcached_maintenance_window" {}

variable "ec_memcached_desired_clusters" {
  default = "1"
}

variable "ec_memcached_instance_type" {
  default = "cache.t2.micro"
}

variable "ec_memcached_engine_version" {
  default = "1.4.33"
}

variable "ec_memcached_alarm_cpu_threshold_percent" {}

variable "ec_memcached_alarm_memory_threshold_bytes" {}

variable "ec_memcached_max_item_size" {
  # 8MB
  default = "8388608"
}

variable "sqs_queue_name" {}

variable "sqs_max_message_size" {}

variable "sqs_receive_wait_time_seconds" {}

variable "sqs_visibility_timeout_seconds" {}

variable "climate_r53_private_hosted_zone" {}

variable "climate_r53_public_hosted_zone" {}

variable "temperate_r53_public_hosted_zone" {}

variable "librato_email" {}

variable "librato_token" {}
