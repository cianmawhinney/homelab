variable "vault_version" {
  default = "1.14.0"
}

source "digitalocean" "vault" {
  image        = "rockylinux-9-x64"
  region       = "lon1"
  size         = "s-1vcpu-1gb"
  ssh_username = "root"
}

build {
  source "source.digitalocean.vault" {
    snapshot_name = "vault-${var.vault_version}-rocky-9"
  }

  provisioner "ansible" {
    playbook_file = "playbook.yml"
    extra_arguments = [
      "-e", "vault_version=${var.vault_version}",
    ]

    # Fix issue with connecting to Rocky 9 by disabling a local SSH proxy
    # Should be fixed in Packer 1.9.2, when the changes from
    # https://github.com/hashicorp/packer-plugin-ansible/pull/162 are included.
    use_proxy = false
  }
}
