variable "minecraft_version" {
  default = "1.19.4"
}

variable "paper_server_build_version" {
  default = "latest"
}

source "digitalocean" "ubuntu-2204-base" {
  image        = "ubuntu-22-04-x64"
  region       = "lon1"
  size         = "s-1vcpu-2gb"
  ssh_username = "root"
}

build {
  source "source.digitalocean.ubuntu-2204-base" {
    snapshot_name = "minecraft-${var.minecraft_version}-ubuntu-22.04"
  }


  provisioner "ansible" {
    playbook_file = "playbook.yml"
    extra_arguments = [
      "--extra-vars", "minecraft_server_version=${var.minecraft_version}",
      "--extra-vars", "paper_server_build_version=${var.paper_server_build_version}",
    ]
  }

}
