source "digitalocean" "ubuntu-2204-base" {
  image        = "ubuntu-22-04-x64"
  region       = "lon1"
  size         = "s-1vcpu-2gb"
  ssh_username = "root"
}

build {
  source "source.digitalocean.ubuntu-2204-base" {
    snapshot_name = "minecraft-1.19.4-ubuntu-22.04"
  }

  provisioner "ansible" {
    playbook_file = "playbook.yml"
  }

}