resource "digitalocean_droplet" "hyq_mc" {
  name = "hyq-mc-01"
  size   = "s-1vcpu-2gb-intel"
  image  = "134883045" # Ubuntu based minecraft image. # TODO: HCP Packer setup (#90)
  region = "lon1"

  ssh_keys = [
    digitalocean_ssh_key.personal_key.fingerprint
  ]

  tags = [
    digitalocean_tag.production.id
  ]

  volume_ids = [
    digitalocean_volume.hyq_mc_data.id
  ]

  user_data = <<EOF
#!/bin/bash

# Automatically mount the volume immediately on VM creation and on subsequent boots
mkdir -p /data
echo "/dev/disk/by-id/scsi-0DO_Volume_${digitalocean_volume.hyq_mc_data.name} /data ext4 defaults,nofail,discard 0 0" >> /etc/fstab
mount -a

# start and enable minecraft service
systemctl enable minecraft.service
systemctl start minecraft.service
EOF

}

resource "digitalocean_volume" "hyq_mc_data" {
  region                  = "lon1"
  name                    = "hyq-mc-data"
  size                    = 10
  initial_filesystem_type = "ext4"
  description             = "Volume for storing Minecraft data"
}

resource "digitalocean_reserved_ip" "hyq_mc_ip" {
  droplet_id = digitalocean_droplet.hyq_mc.id
  region     = digitalocean_droplet.hyq_mc.region
}


output "hyq_mc_droplet_ip" {
  value = digitalocean_droplet.hyq_mc.ipv4_address
}

output "hyq_mc_droplet_ip_floating" {
  value = digitalocean_reserved_ip.hyq_mc_ip.ip_address
}
