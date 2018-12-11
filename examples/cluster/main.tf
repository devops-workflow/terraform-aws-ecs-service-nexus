//
// ECS Services
//

module "nexus" {
  source                    = "../../"
  name                      = "nexus"
  ecs_cluster_arn           = "${module.ecs-cluster.cluster_id}"
  ecs_desired_count         = 1
  ecs_security_group_id     = "${module.ecs-cluster.cluster_security_group_id}"
  environment               = "${var.environment}"
  organization              = "${var.organization}"
  acm_cert_domain           = "${var.acm_cert_domain}"
  docker_image              = "sonatype/nexus3"
  docker_memory             = 2048
  docker_memory_reservation = 2048
  lb_enable_http            = false
  lb_enable_https           = true
  lb_https_ports            = "443"
  lb_ingress_cidr_blocks    = "${var.lb_ingress_cidr_blocks}"
  lb_internal               = false
  lb_subnet_ids             = ["${data.aws_subnet_ids.public_subnet_ids.ids}"]
  region                    = "${var.region}"
  vpc_id                    = "${data.aws_vpc.vpc.id}"
  mount_point               = "/mnt/efs/${module.efs_service_nexus.name}"
}

/**/

