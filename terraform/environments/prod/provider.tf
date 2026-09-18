terraform {
  cloud {
    organization = "cianmawhinney-homelab"

    workspaces {
      name = "production"
    }
  }

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.69.0"
    }

    flux = {
      source  = "fluxcd/flux"
      version = "~> 1.9.0"
    }
  }
}

variable "hcloud_token" {
  sensitive = true
}
provider "hcloud" {
  token = var.hcloud_token
}


variable "github_org" {
  description = "The GitHub organisation/user that owns the repo containing the Flux K8s config"
  default     = "cianmawhinney"
}

variable "github_repository" {
  description = "The GitHub repository containing the Flux K8s config"
  default     = "homelab"
}

variable "github_branch" {
  description = "Branch of the Flux K8s config repo to reconcile from"
  default     = "master"
}

variable "github_token" {
  description = "GitHub PAT for interacting with Flux K8s config repo"
  sensitive   = true
}
