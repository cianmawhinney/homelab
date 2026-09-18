variable "cluster_name" {
  description = "Name of the k3s cluster"
  type        = string
}

variable "hcloud_token" {
  sensitive = true
}

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
