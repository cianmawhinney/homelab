terraform {
  cloud {
    organization = "cianmawhinney-homelab"

    workspaces {
      name = "homelab"
    }
  }

  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "2.9.9"
    }
  }
}

provider "proxmox" {
  # Configuration options
}
