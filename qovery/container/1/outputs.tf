output "container_id" {
  description = "Qovery container service ID"
  value       = qovery_container.this.id
}

output "container_name" {
  description = "Container service name"
  value       = qovery_container.this.name
}
