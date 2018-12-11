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
  description = "Prefix name with the organization. If true, format is: {org}-{env namespaced name}. If both env and org namespaces are used, format will be {org}-{env}-{name}"
  default     = false
}

variable "organization" {
  description = "Organization name (Top level namespace)."
  default     = "example"
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
  default     = "*.example.com"
}

variable "aws_profile" {
  default = "example"
}

variable "instance_type" {
  description = "AWS Instance type, if you change, make sure it is compatible with AMI, not all AMIs allow all instance types "
  default     = "t3.medium"
}

variable "key_name" {
  description = "SSH key name to use"
  default     = "devops-2018-12-04"
}

variable "lb_ingress_cidr_blocks" {
  description = "CIDR block to whitelist for the load balancer"
  type        = "list"
  default     = ["0.0.0.0/0"]
}

variable "region" {
  default = "us-east-1"
}
