source "digitalocean" "vault" {
  image        = "rockylinux-9-x64"
  region       = "lon1"
  size         = "s-1vcpu-1gb"
  ssh_username = "root"
}

build {
  source "source.digitalocean.vault" {
    snapshot_name = "vault-version-idk"
  }

  provisioner "ansible" {
    playbook_file = "playbook.yml"
  }
}
