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

  cluster_name = "k3s-prod"

  hcloud_token            = var.hcloud_token
  cluster_ssh_public_key  = var.cluster_ssh_public_key
  cluster_ssh_private_key = var.cluster_ssh_private_key
}

# See the matching moved blocks in environments/dev/main.tf: harmless no-ops
# here unless this workspace already had state from the old flat config.
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

