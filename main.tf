//
// ECS Services
//
locals {
  ulimits = "${jsonencode(
    map("ulimits",
      list(map(
        "name","nofile",
        "hardLimit",65536,
        "softLimit",65536
      ))))}"

  c                               = "${substr(local.ulimits, 1, length(local.ulimits) - 2)}"
  container_definition_additional = "${replace(local.c, "/\"([0-9]+)\"/", "$1")}"
}

module "nexus" {
  source                = "devops-workflow/ecs-service/aws"
  version               = "3.0.0"
  name                  = "${var.name}"
  ecs_cluster_arn       = "${var.ecs_cluster_arn}"
  ecs_desired_count     = 1
  ecs_security_group_id = "${var.ecs_security_group_id}"
  environment           = "${var.environment}"
  organization          = "${var.organization}"

  #docker_registry = "105667981759.dkr.ecr.us-west-2.amazonaws.com/wiser"
  docker_image = "sonatype/nexus3"

  acm_cert_domain           = "${var.acm_cert_domain}"
  app_port                  = 8081                            # target group & container port
  docker_memory             = 2048
  docker_memory_reservation = 2048
  lb_enable_http            = "${var.lb_enable_http}"         #false
  lb_enable_https           = "${var.lb_enable_https}"        #true
  lb_internal               = "${var.lb_internal}"            #false
  lb_https_ports            = "${var.lb_https_ports}"         #"443"
  lb_ingress_cidr_blocks    = "${var.lb_ingress_cidr_blocks}"
  lb_subnet_ids             = ["${var.lb_subnet_ids}"]
  region                    = "${var.region}"
  vpc_id                    = "${var.vpc_id}"

  container_definition_additional = "${local.container_definition_additional}"

  docker_port_mappings = "${list(
    map("containerPort", 8081, "hostPort", 8081, "protocol", "tcp")
    )}"

  docker_mount_points = "${list(
    map("containerPath", "/nexus-data", "sourceVolume", "efs")
    )}"

  docker_volumes = "${list(
    map("name", "efs", "host_path", "${var.mount_point}")
    )}"
}
