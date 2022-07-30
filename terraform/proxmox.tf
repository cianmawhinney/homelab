variable "proxmox_url" {
    type = string
    description = "The URL to connect to the Proxmox cluster with"
}

variable "proxmox_node" {
    type = string
    description = "The node on the Proxmox cluster to provision resources on"
}


variable "proxmox_username" {
    type = string
    description = "The username to connect to the Proxmox cluster with"
}

variable "proxmox_token_id" {
    type = string
    description = "The identifier for the auth token to be used"
}

variable "proxmox_token_secret" {
    type = string
    description = "The identifier for the auth token to be used"
}

provider "proxmox" {
  pm_api_url = var.proxmox_url
  pm_user = var.proxmox_username
  pm_api_token_id = var.proxmox_token_id
  pm_api_token_secret = var.proxmox_token_secret
}
