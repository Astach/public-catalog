# Qovery-injected variables (auto-filled from platform context)
variable "qovery_organization_id" {
  type        = string
  description = "Qovery organization ID"
}

variable "qovery_project_id" {
  type        = string
  description = "Qovery project ID"
}

variable "qovery_environment_id" {
  type        = string
  description = "Qovery environment ID"
}

variable "qovery_cluster_id" {
  type        = string
  description = "Qovery cluster ID"
}

# User-provided variables
variable "container_name" {
  type        = string
  description = "Name of the container service"
}

variable "image_name" {
  type        = string
  default     = "nginx"
  description = "Docker image name"
}

variable "image_tag" {
  type        = string
  default     = "1.27-alpine"
  description = "Docker image tag (must not be 'latest')"
}

variable "cpu" {
  type        = number
  default     = 250
  description = "CPU in millicores"
}

variable "memory" {
  type        = number
  default     = 256
  description = "Memory in MiB"
}

variable "port" {
  type        = number
  default     = 80
  description = "Container port to expose"
}
