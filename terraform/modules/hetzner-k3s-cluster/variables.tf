variable "ssh_keys" {
  description = "SSH keys to be added to the cluster nodes"
  default = []
  type = list(object({
    id: string
  }))
}

locals {
  ssh_key_ids = [for key in var.ssh_keys : key.id]
}

resource "random_password" "k3s_token" {
    length = 16
    special = false
}
