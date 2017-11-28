#
# Bastion security group resources
#
resource "aws_security_group_rule" "bastion_ssh_ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${var.external_access_cidr_block}"]
  security_group_id = "${module.vpc.bastion_security_group_id}"
}

resource "aws_security_group_rule" "bastion_ssh_egress" {
  type              = "egress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${module.vpc.cidr_block}"]
  security_group_id = "${module.vpc.bastion_security_group_id}"
}

resource "aws_security_group_rule" "bastion_http_egress" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${module.vpc.bastion_security_group_id}"
}

resource "aws_security_group_rule" "bastion_https_egress" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${module.vpc.bastion_security_group_id}"
}

resource "aws_security_group_rule" "bastion_postgresql_egress" {
  type                     = "egress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = "${module.vpc.bastion_security_group_id}"
  source_security_group_id = "${module.database.database_security_group_id}"
}

resource "aws_security_group_rule" "bastion_memcached_egress" {
  type                     = "egress"
  from_port                = 11211
  to_port                  = 11211
  protocol                 = "tcp"
  security_group_id        = "${module.vpc.bastion_security_group_id}"
  source_security_group_id = "${module.cache.cache_security_group_id}"
}

#
# RDS security group resources
#
resource "aws_security_group_rule" "postgresql_bastion_ingress" {
  type      = "ingress"
  from_port = 5432
  to_port   = 5432
  protocol  = "tcp"

  security_group_id        = "${module.database.database_security_group_id}"
  source_security_group_id = "${module.vpc.bastion_security_group_id}"
}

resource "aws_security_group_rule" "postgresql_bastion_egress" {
  type      = "egress"
  from_port = 5432
  to_port   = 5432
  protocol  = "tcp"

  security_group_id        = "${module.database.database_security_group_id}"
  source_security_group_id = "${module.vpc.bastion_security_group_id}"
}

resource "aws_security_group_rule" "postgresql_container_instance_ingress" {
  type      = "ingress"
  from_port = 5432
  to_port   = 5432
  protocol  = "tcp"

  security_group_id        = "${module.database.database_security_group_id}"
  source_security_group_id = "${module.container_service_cluster.container_instance_security_group_id}"
}

resource "aws_security_group_rule" "postgresql_container_instance_egress" {
  type      = "egress"
  from_port = 5432
  to_port   = 5432
  protocol  = "tcp"

  security_group_id        = "${module.database.database_security_group_id}"
  source_security_group_id = "${module.container_service_cluster.container_instance_security_group_id}"
}

#
# Memcached security group resources
#
resource "aws_security_group_rule" "memcached_bastion_ingress" {
  type      = "ingress"
  from_port = 11211
  to_port   = 11211
  protocol  = "tcp"

  security_group_id        = "${module.cache.cache_security_group_id}"
  source_security_group_id = "${module.vpc.bastion_security_group_id}"
}

resource "aws_security_group_rule" "memcached_bastion_egress" {
  type      = "egress"
  from_port = 11211
  to_port   = 11211
  protocol  = "tcp"

  security_group_id        = "${module.cache.cache_security_group_id}"
  source_security_group_id = "${module.vpc.bastion_security_group_id}"
}

resource "aws_security_group_rule" "memcached_container_instance_ingress" {
  type      = "ingress"
  from_port = 11211
  to_port   = 11211
  protocol  = "tcp"

  security_group_id        = "${module.cache.cache_security_group_id}"
  source_security_group_id = "${module.container_service_cluster.container_instance_security_group_id}"
}

resource "aws_security_group_rule" "memcached_container_instance_egress" {
  type      = "egress"
  from_port = 11211
  to_port   = 11211
  protocol  = "tcp"

  security_group_id        = "${module.cache.cache_security_group_id}"
  source_security_group_id = "${module.container_service_cluster.container_instance_security_group_id}"
}

#
# Container instance security group resources
#
resource "aws_security_group_rule" "container_instance_http_egress" {
  type        = "egress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${module.container_service_cluster.container_instance_security_group_id}"
}

resource "aws_security_group_rule" "container_instance_https_egress" {
  type        = "egress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${module.container_service_cluster.container_instance_security_group_id}"
}

resource "aws_security_group_rule" "container_instance_postgresql_egress" {
  type      = "egress"
  from_port = 5432
  to_port   = 5432
  protocol  = "tcp"

  security_group_id        = "${module.container_service_cluster.container_instance_security_group_id}"
  source_security_group_id = "${module.database.database_security_group_id}"
}

resource "aws_security_group_rule" "container_instance_memcached_egress" {
  type      = "egress"
  from_port = 11211
  to_port   = 11211
  protocol  = "tcp"

  security_group_id        = "${module.container_service_cluster.container_instance_security_group_id}"
  source_security_group_id = "${module.cache.cache_security_group_id}"
}

resource "aws_security_group_rule" "container_instance_bastion_ssh_ingress" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"

  security_group_id        = "${module.container_service_cluster.container_instance_security_group_id}"
  source_security_group_id = "${module.vpc.bastion_security_group_id}"
}
