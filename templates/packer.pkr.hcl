packer {
  required_plugins {
    proxmox-iso = {
      version = ">= 1.0.6"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

variable "proxmox_url" {
  type = string
}

variable "proxmox_node" {
  type = string
}

variable "proxmox_username" {
  type = string
}

variable "proxmox_token_id" {
  type = string
}

variable "proxmox_token_secret" {
  type = string
}