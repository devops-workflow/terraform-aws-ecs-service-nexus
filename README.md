# terraform-aws-ecs-service-nexus

[![CircleCI](https://circleci.com/gh/devops-workflow/terraform-aws-ecs-service-nexus.svg?style=svg)](https://circleci.com/gh/devops-workflow/terraform-aws-ecs-service-nexus)
[![Github release](https://img.shields.io/github/release/devops-workflow/terraform-aws-ecs-service-nexus.svg)](https://github.com/devops-workflow/terraform-aws-ecs-service-nexus/releases)

Terraform module to manage Nexus service in an ECS cluster

[Terraform registry](https://registry.terraform.io/modules/devops-workflow/ecs-service-nexus/aws)

## Usage

### Basic Example

```hcl
module "" {
  source        = "devops-workflow/ecs-service-nexus/aws"
  version       = "0.0.1"
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| acm\_cert\_domain | Domain name of ACM-managed certificate | string | `` | no |
| attributes | Suffix name with additional attributes (policy, role, etc.) | list | `<list>` | no |
| aws\_profile | - | string | `` | no |
| delimiter | Delimiter to be used between `name`, `namespaces`, `attributes`, etc. | string | `-` | no |
| docker\_image | Docker image to use for task | string | `sonatype/nexus3` | no |
| docker\_memory | Hard limit on memory use for task container (default 256) | string | `2048` | no |
| docker\_memory\_reservation | Soft limit on memory use for task container (default 128) | string | `2048` | no |
| ecs\_cluster\_arn | ARN of ECS cluster in which the service will be deployed | string | `` | no |
| ecs\_desired\_count | Desired number of containers in the task (default 1) | string | `1` | no |
| ecs\_security\_group\_id | Security group ID of ECS cluster in which the service will be deployed | string | `` | no |
| environment | Environment (ex: `dev`, `qa`, `stage`, `prod`). (Second or top level namespace. Depending on namespacing options) | string | `mgmt` | no |
| instance\_type | AWS Instance type, if you change, make sure it is compatible with AMI, not all AMIs allow all instance types | string | `t3.medium` | no |
| key\_name | SSH key name to use | string | `devops-2018-12-04` | no |
| lb\_enable\_http | Enable HTTP listener in LB (http or https MUST be enabled) | string | `true` | no |
| lb\_enable\_https | Enable HTTPS listener in LB (http or https MUST be enabled) | string | `false` | no |
| lb\_https\_ports | - | string | `443` | no |
| lb\_ingress\_cidr\_blocks | CIDR block to whitelist for the load balancer | list | `<list>` | no |
| lb\_internal | Configure LB as internal-only | string | `true` | no |
| lb\_subnet\_ids | VPC subnet IDs in which to create the LB (unnecessary if neither lb_enable_https or lb_enable_http are true) | list | `<list>` | no |
| mount\_point | Host directory to map as /nexus-data in container | string | `` | no |
| name | Base name for resources | string | `nexus` | no |
| namespace-env | Prefix name with the environment. If true, format is: {env}-{name} | string | `true` | no |
| namespace-org | Prefix name with the organization. If true, format is: {org}-{env namespaced name}. If both env and org namespaces are used, format will be {org}-{env}-{name} | string | `false` | no |
| organization | Organization name (Top level namespace). | string | `appzen` | no |
| region | - | string | `us-east-1` | no |
| tags | A map of additional tags | map | `<map>` | no |
| vpc\_id | ID of VPC in which ECS cluster is located | string | `` | no |

## Outputs

| Name | Description |
|------|-------------|
| container\_json | - |
| service\_iam\_role\_arn | ARN of the IAM Role for the ECS Service |
| service\_iam\_role\_name | Name of the IAM Role for the ECS Task |
| task\_iam\_role\_arn | ARN of the IAM Role for the ECS Task |
| task\_iam\_role\_name | Name of the IAM Role for the ECS Task |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM GRAPH HOOK -->

### Resource Graph of plan

![Terraform Graph](resource-plan-graph.png)
<!-- END OF PRE-COMMIT-TERRAFORM GRAPH HOOK -->
