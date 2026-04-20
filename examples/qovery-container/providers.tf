terraform {
  required_version = ">= 1.5"

  required_providers {
    qovery = {
      source  = "Qovery/qovery"
      version = "~> 0.17"
    }
  }
}

# The Qovery provider authenticates via QOVERY_API_TOKEN env var,
# injected by the engine from the cluster credentials.
provider "qovery" {}
