//
// Variables specific to module label
//
variable "attributes" {
  description = "Suffix name with additional attributes (policy, role, etc.)"
  type        = "list"
  default     = []
}

variable "delimiter" {
  description = "Delimiter to be used between `name`, `namespaces`, `attributes`, etc."
  default     = "-"
}

variable "environment" {
  description = "Environment (ex: `dev`, `qa`, `stage`, `prod`). (Second or top level namespace. Depending on namespacing options)"
  default     = "mgmt"
}

variable "name" {
  description = "Base name for resources"
  default     = "nexus"
}

variable "namespace-env" {
  description = "Prefix name with the environment. If true, format is: {env}-{name}"
  default     = true
}

variable "namespace-org" {
  description = "Prefix name with the organization. If true, format is: {org}-{env namespaced name}. If both env and org namespaces are used, format will be <org>-<env>-<name>"
  default     = false
}

variable "organization" {
  description = "Organization name (Top level namespace)."
  default     = "appzen"
}

variable "tags" {
  description = "A map of additional tags"
  type        = "map"
  default     = {}
}

//
// Variables specific to Nexus module
//
variable "acm_cert_domain" {
  description = "Domain name of ACM-managed certificate"
  type        = "string"
  default     = ""
}

variable "aws_profile" {
  default = ""
}

variable "docker_image" {
  description = "Docker image to use for task"
  type        = "string"
  default     = "sonatype/nexus3"
}

variable "docker_memory" {
  description = "Hard limit on memory use for task container (default 256)"
  default     = 2048
}

variable "docker_memory_reservation" {
  description = "Soft limit on memory use for task container (default 128)"
  default     = 2048
}

variable "ecs_cluster_arn" {
  description = "ARN of ECS cluster in which the service will be deployed"
  type        = "string"
  default     = ""
}

variable "ecs_security_group_id" {
  description = "Security group ID of ECS cluster in which the service will be deployed"
  type        = "string"
  default     = ""
}

variable "ecs_desired_count" {
  description = "Desired number of containers in the task (default 1)"
  type        = "string"
  default     = 1
}

variable "instance_type" {
  description = "AWS Instance type, if you change, make sure it is compatible with AMI, not all AMIs allow all instance types "
  default     = "t3.medium"
}

variable "key_name" {
  description = "SSH key name to use"
  default     = "devops-2018-12-04"
}

variable "lb_enable_https" {
  description = "Enable HTTPS listener in LB (http or https MUST be enabled)"
  default     = "false"
}

variable "lb_enable_http" {
  description = "Enable HTTP listener in LB (http or https MUST be enabled)"
  default     = "true"
}

variable "lb_https_ports" {
  default = "443"
}

variable "lb_internal" {
  description = "Configure LB as internal-only"
  default     = "true"
}

variable "lb_ingress_cidr_blocks" {
  description = "CIDR block to whitelist for the load balancer"
  type        = "list"
  default     = ["0.0.0.0/0"]
}

variable "lb_subnet_ids" {
  description = "VPC subnet IDs in which to create the LB (unnecessary if neither lb_enable_https or lb_enable_http are true)"
  type        = "list"
  default     = []
}

variable "mount_point" {
  description = "Host directory to map as /nexus-data in container"
  default     = ""
}

variable "region" {
  default = "us-east-1"
}

variable "vpc_id" {
  description = "ID of VPC in which ECS cluster is located"
  type        = "string"
  default     = ""
}
