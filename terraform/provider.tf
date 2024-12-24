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
      version = "~> 1.49.1"
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

