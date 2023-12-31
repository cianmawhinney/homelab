terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "ssh_keys" {
  description = "A list of digitalocean_ssh_key objects to be loaded onto the droplet"
  type = list(object({
    fingerprint: string
  }))
  default = []
}

variable "resource_tags" {
  description = "A list of digitalocean_tag objects to associate with the server"
  type = list(object({
    id: string
  }))
  default = []
}

variable "name" {
  description = "A base name for the instantiated resources"
  type = string
  default = "mc"
}

locals {
  ssh_keys = [for key in var.ssh_keys: key.fingerprint]
  resource_tags = [for tag in var.resource_tags: tag.id]
}

resource "digitalocean_droplet" "mc_droplet" {
  name   = "${var.name}-01"
  size   = "s-1vcpu-2gb-intel"
  image  = "134883045" # Ubuntu based minecraft image. # TODO: HCP Packer setup (#90)
  region = "lon1"

  ssh_keys = local.ssh_keys
  tags = local.resource_tags

  volume_ids = [
    digitalocean_volume.server_data.id
  ]

  user_data = <<EOF
#!/bin/bash

# Automatically mount the volume immediately on VM creation and on subsequent boots
mkdir -p /data
echo "/dev/disk/by-id/scsi-0DO_Volume_${digitalocean_volume.server_data.name} /data ext4 defaults,nofail,discard 0 0" >> /etc/fstab
mount -a

# start and enable minecraft service
systemctl enable minecraft.service
systemctl start minecraft.service
EOF

}

resource "digitalocean_volume" "server_data" {
  region                  = "lon1"
  name                    = "${var.name}-data"
  size                    = 10
  initial_filesystem_type = "ext4"
  description             = "Volume for storing Minecraft data"
}

resource "digitalocean_reserved_ip" "server_reserved_ip" {
  droplet_id = digitalocean_droplet.mc_droplet.id
  region     = digitalocean_droplet.mc_droplet.region
}


output "server_droplet_ip" {
  value = digitalocean_droplet.mc_droplet.ipv4_address
}

output "server_droplet_ip_floating" {
  value = digitalocean_reserved_ip.server_reserved_ip.ip_address
}
