packer {
  required_plugins {
    proxmox-iso = {
      version = ">= 1.0.6"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}