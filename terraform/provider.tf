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
  }
}

variable "do_token" {
  sensitive = true
}
provider "digitalocean" {
  token = var.do_token
}
