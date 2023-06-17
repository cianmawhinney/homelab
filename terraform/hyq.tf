resource "digitalocean_droplet" "hyq_mc" {
  name = "hyq-mc-01"
  size   = "s-1vcpu-2gb-intel"
  image  = "131659741"
  region = "lon1"

  ssh_keys = [
    digitalocean_ssh_key.personal_key.fingerprint
  ]

  tags = [
    digitalocean_tag.production.id
  ]
}

resource "digitalocean_volume" "hyq_mc_data" {
  region                  = "lon1"
  name                    = "hyq-mc-data"
  size                    = 10
  initial_filesystem_type = "ext4"
  description             = "Volume for storing Minecraft data"
}

resource "digitalocean_volume_attachment" "hyq_mc_data_attachment" {
  droplet_id = digitalocean_droplet.hyq_mc.id
  volume_id  = digitalocean_volume.hyq_mc_data.id
}
