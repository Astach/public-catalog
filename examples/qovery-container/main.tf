# Look up the Docker Hub registry in the Qovery organization.
# Qovery auto-creates a Docker Hub registry for every organization.
data "qovery_container_registry" "docker_hub" {
  organization_id = var.qovery_organization_id
  name            = "Docker Hub"
}

resource "qovery_container" "this" {
  environment_id = var.qovery_environment_id
  registry_id    = data.qovery_container_registry.docker_hub.id
  name           = var.container_name
  image_name     = var.image_name
  tag            = var.image_tag

  cpu    = var.cpu
  memory = var.memory

  min_running_instances = 1
  max_running_instances = 1
  auto_deploy           = true

  ports = {
    items = [
      {
        internal_port       = var.port
        external_port       = 443
        publicly_accessible = true
        protocol            = "HTTP"
        is_default          = true
        name                = "http"
      }
    ]
  }

  healthchecks = {
    readiness_probe = {
      type = {
        tcp = {
          port = var.port
        }
      }
      initial_delay_seconds = 10
      period_seconds        = 10
      timeout_seconds       = 5
      success_threshold     = 1
      failure_threshold     = 3
    }
    liveness_probe = {
      type = {
        tcp = {
          port = var.port
        }
      }
      initial_delay_seconds = 10
      period_seconds        = 10
      timeout_seconds       = 5
      success_threshold     = 1
      failure_threshold     = 3
    }
  }
}
