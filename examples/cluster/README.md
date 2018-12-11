# terraform-aws-ecs-service-nexus: Cluster

This builds an ECS cluster with a Nexus service running

## Features

- Nexus file stored on EFS
- Public interface with SSL and whitelist

## Usage

To run this example you need to execute:

```bash
terraform init
terraform plan
terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| acm\_cert\_domain | Domain name of ACM-managed certificate | string | `*.example.com` | no |
| attributes | Suffix name with additional attributes (policy, role, etc.) | list | `<list>` | no |
| aws\_profile | - | string | `example` | no |
| delimiter | Delimiter to be used between `name`, `namespaces`, `attributes`, etc. | string | `-` | no |
| environment | Environment (ex: `dev`, `qa`, `stage`, `prod`). (Second or top level namespace. Depending on namespacing options) | string | `mgmt` | no |
| instance\_type | AWS Instance type, if you change, make sure it is compatible with AMI, not all AMIs allow all instance types | string | `t3.medium` | no |
| key\_name | SSH key name to use | string | `devops-2018-12-04` | no |
| lb\_ingress\_cidr\_blocks | CIDR block to whitelist for the load balancer | list | `<list>` | no |
| name | Base name for resources | string | `nexus` | no |
| namespace-env | Prefix name with the environment. If true, format is: {env}-{name} | string | `true` | no |
| namespace-org | Prefix name with the organization. If true, format is: {org}-{env namespaced name}. If both env and org namespaces are used, format will be <org>-<env>-<name> | string | `false` | no |
| organization | Organization name (Top level namespace). | string | `example` | no |
| region | - | string | `us-east-1` | no |
| tags | A map of additional tags | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| service\_iam\_role\_arn | ARN of the IAM Role for the ECS Service |
| service\_iam\_role\_name | Name of the IAM Role for the ECS Task |
| task\_iam\_role\_arn | ARN of the IAM Role for the ECS Task |
| task\_iam\_role\_name | Name of the IAM Role for the ECS Task |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
