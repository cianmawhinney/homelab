variable "cluster_ssh_public_key" {
  description = "Main SSH public key for cluster"
  type        = string
  default     = null
}

variable "cluster_ssh_private_key" {
  description = "Main SSH private key for cluster"
  type        = string
  default     = null
  sensitive   = true
}

module "cluster" {
  source = "../../modules/cluster"
  providers = {
    hcloud = hcloud
  }

  cluster_name = "k3s-dev"

  hcloud_token            = var.hcloud_token
  cluster_ssh_public_key  = var.cluster_ssh_public_key
  cluster_ssh_private_key = var.cluster_ssh_private_key
}

# These resources used to live directly in this root module (before the
# terraform/environments split and the modules/cluster extraction). Without
# these, Terraform would plan to destroy and recreate the actual cluster
# nodes instead of recognising they just moved.
moved {
  from = hcloud_ssh_key.personal_laptop_key
  to   = module.cluster.hcloud_ssh_key.personal_laptop_key
}

moved {
  from = hcloud_ssh_key.personal_desktop_key
  to   = module.cluster.hcloud_ssh_key.personal_desktop_key
}

moved {
  from = module.kube-hetzner
  to   = module.cluster.module.kube-hetzner
}

