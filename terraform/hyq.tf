resource "digitalocean_droplet" "hyq_mc" {
  name = "hyq-mc-01"
  size   = "s-1vcpu-2gb-intel"
  image  = "134843480" # Ubuntu based minecraft image. # TODO: HCP Packer setup (#90)
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
EOF

}

resource "digitalocean_volume" "hyq_mc_data" {
  region                  = "lon1"
  name                    = "hyq-mc-data"
  size                    = 10
  initial_filesystem_type = "ext4"
  description             = "Volume for storing Minecraft data"
}
