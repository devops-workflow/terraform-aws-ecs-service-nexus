output "task_iam_role_arn" {
  description = "ARN of the IAM Role for the ECS Task"
  value       = "${module.nexus.task_iam_role_arn}"
}

output "task_iam_role_name" {
  description = "Name of the IAM Role for the ECS Task"
  value       = "${module.nexus.task_iam_role_name}"
}

output "service_iam_role_arn" {
  description = "ARN of the IAM Role for the ECS Service"
  value       = "${module.nexus.service_iam_role_arn}"
}

output "service_iam_role_name" {
  description = "Name of the IAM Role for the ECS Task"
  value       = "${module.nexus.service_iam_role_name}"
}

output "container_json" {
  description = ""
  value       = "${module.nexus.container_json}"
}
