#
# EC2 IAM resources
#
data "aws_iam_policy_document" "container_instance_ses_send_email" {
  statement {
    effect = "Allow"

    resources = ["*"]
    actions   = ["ses:SendRawEmail"]
  }
}

resource "aws_iam_role_policy" "ses_send_email_policy" {
  name   = "SESSendEmail"
  role   = "${module.container_service_cluster.container_instance_ecs_for_ec2_service_role_name}"
  policy = "${data.aws_iam_policy_document.container_instance_ses_send_email.json}"
}

resource "aws_iam_role_policy_attachment" "cloudwatch_logs_policy_container_instance_role" {
  role       = "${module.container_service_cluster.container_instance_ecs_for_ec2_service_role_name}"
  policy_arn = "${var.aws_cloudwatch_logs_policy_arn}"
}

resource "aws_iam_role_policy_attachment" "sqs_policy_container_instance_role" {
  role       = "${module.container_service_cluster.container_instance_ecs_for_ec2_service_role_name}"
  policy_arn = "${var.aws_sqs_policy_arn}"
}

resource "aws_iam_role_policy_attachment" "s3_policy_container_instance_role" {
  role       = "${module.container_service_cluster.container_instance_ecs_for_ec2_service_role_name}"
  policy_arn = "${var.aws_s3_policy_arn}"
}
