#
# Autoscaling Resources
#
data "template_file" "container_instance_cloud_config" {
  template = "${file("cloud-config/container-instance.yml.tpl")}"

  vars {
    environment   = "${var.environment}"
    librato_email = "${var.librato_email}"
    librato_token = "${var.librato_token}"
  }
}

#
# ECS resources
#
module "container_service_cluster" {
  source = "github.com/azavea/terraform-aws-ecs-cluster?ref=0.8.0"

  root_block_device_type = "${var.container_instance_root_block_device_type}"
  root_block_device_size = "${var.container_instance_root_block_device_size}"

  lookup_latest_ami = true
  vpc_id            = "${module.vpc.id}"
  instance_type     = "${var.container_instance_type}"
  key_name          = "${var.aws_key_name}"
  cloud_config      = "${data.template_file.container_instance_cloud_config.rendered}"

  health_check_grace_period = "600"
  desired_capacity          = "${var.container_instance_asg_desired_capacity}"
  min_size                  = "${var.container_instance_asg_min_size}"
  max_size                  = "${var.container_instance_asg_max_size}"

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]

  private_subnet_ids = ["${module.vpc.private_subnet_ids}"]

  scale_up_cooldown_seconds      = "${var.container_instance_asg_scale_up_cooldown_seconds}"
  scale_down_cooldown_seconds    = "${var.container_instance_asg_scale_down_cooldown_seconds}"
  high_cpu_evaluation_periods    = "${var.container_instance_asg_high_cpu_evaluation_periods}"
  high_cpu_period_seconds        = "${var.container_instance_asg_high_cpu_period_seconds}"
  high_cpu_threshold_percent     = "${var.container_instance_asg_high_cpu_threshold_percent}"
  low_cpu_evaluation_periods     = "${var.container_instance_asg_low_cpu_evaluation_periods}"
  low_cpu_period_seconds         = "${var.container_instance_asg_low_cpu_period_seconds}"
  low_cpu_threshold_percent      = "${var.container_instance_asg_low_cpu_threshold_percent}"
  high_memory_evaluation_periods = "${var.container_instance_asg_high_memory_evaluation_periods}"
  high_memory_period_seconds     = "${var.container_instance_asg_high_memory_period_seconds}"
  high_memory_threshold_percent  = "${var.container_instance_asg_high_memory_threshold_percent}"
  low_memory_evaluation_periods  = "${var.container_instance_asg_low_memory_evaluation_periods}"
  low_memory_period_seconds      = "${var.container_instance_asg_low_memory_period_seconds}"
  low_memory_threshold_percent   = "${var.container_instance_asg_low_memory_threshold_percent}"

  project     = "${var.project}"
  environment = "${var.environment}"
}
