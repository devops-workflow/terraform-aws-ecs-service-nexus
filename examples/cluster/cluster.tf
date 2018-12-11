//
// EFS setup
//
module "efs_service_nexus" {
  source       = "devops-workflow/efs/aws"
  version      = "0.6.1"
  name         = "nexus"
  attributes   = ["efs"]
  environment  = "${var.environment}"
  region       = "${var.region}"
  vpc_id       = "${data.aws_vpc.vpc.id}"
  subnets      = "${data.aws_subnet_ids.private_subnet_ids.ids}"
  ingress_cidr = "${data.aws_subnet.private_subnets.*.cidr_block}"
}

//
// ECS cluster setup
//
data "template_file" "extra_user_data" {
  template = "${file("${path.module}/templates/userdata-nfs.sh")}"

  vars {
    mounts = "${module.efs_service_nexus.dns_name}:${module.efs_service_nexus.name}"
  }
}

module "ecs-cluster" {
  source                      = "devops-workflow/ecs-cluster/aws"
  version                     = "6.0.0"
  name                        = "infra"
  environment                 = "${var.environment}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  min_servers                 = "1"
  servers                     = "1"
  subnet_id                   = ["${data.aws_subnet_ids.private_subnet_ids.ids}"]
  vpc_id                      = "${data.aws_vpc.vpc.id}"
  additional_user_data_script = "${data.template_file.extra_user_data.rendered}"
}

# Add ECS Cluster SG to EFS security groups
resource "aws_security_group_rule" "ecs-cluster-efs-service-nexus" {
  description              = "ECS Cluster"
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  security_group_id        = "${module.efs_service_nexus.security_group}"
  source_security_group_id = "${module.ecs-cluster.cluster_security_group_id}"
}
