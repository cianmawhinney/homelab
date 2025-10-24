terraform {
  cloud {
    organization = "cianmawhinney-homelab"

    workspaces {
      tags = [ "homelab" ]
    }
  }

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }

    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.54.0"
    }

    flux = {
      source = "fluxcd/flux"
      version = "~> 1.6.0"
    }
  }
}

variable "do_token" {
  sensitive = true
}
provider "digitalocean" {
  token = var.do_token
}


variable "hcloud_token" {
  sensitive = true
}
provider "hcloud" {
  token = var.hcloud_token
}


variable "github_org" {
  description = "The GitHub organisation/user that owns the repo containing the Flux K8s config"
  default = "cianmawhinney"
}

variable "github_repository" {
  description = "The GitHub repository containing the Flux K8s config"
  default = "flux-testing"
}

variable "github_token" {
  description = "GitHub PAT for interacting with Flux K8s config repo"
}
provider "flux" {
  kubernetes = {
    host                   = module.k3s-eu-central.api_endpoint
    client_certificate     = module.k3s-eu-central.client_certificate
    client_key             = module.k3s-eu-central.client_key
    cluster_ca_certificate = module.k3s-eu-central.cluster_ca_certificate
  }
  git = {
    url = "https://github.com/${var.github_org}/${var.github_repository}.git"
    http = {
      username = "git" # This can be any string when using a personal access token
      password = var.github_token
    }
  }
}
