variable "url" {
  type = string
}

variable "node" {
  type = string
}

variable "username" {
  type = string
}

variable "password" {
  type = string
}

// allow overriding of the IP used to host autoinstall config
variable "builderip" {
  type = string
  default = "{{ .HTTPIP }}"
}

source "proxmox" "ubuntu-2004" {

  proxmox_url          = "${var.url}"
  node                 = "${var.node}"
  username             = "${var.username}"
  password             = "${var.password}"

  template_description = "Ubuntu 20.04.4 image, generated on ${timestamp()}"
  template_name        = "ubuntu-2004"
  
  // iso_urls = [
  //   "ubuntu-20.04.4-live-server-amd64.iso",
  //   "http://releases.ubuntu.com/focal/ubuntu-20.04.4-live-server-amd64.iso"
  // ]

  // assumes file is present on proxmox server
  iso_file = "local:iso/ubuntu-20.04.4-live-server-amd64.iso"
  iso_storage_pool = "local"
  iso_checksum = "sha256:28ccdb56450e643bad03bb7bcf7507ce3d8d90e8bf09e38f6bd9ac298a98eaad"

  os = "l26"
  
  scsi_controller = "virtio-scsi-pci"
  disks {
    disk_size         = "8G"
    storage_pool      = "local-lvm"
    storage_pool_type = "lvm"
    type              = "scsi"
  }

  cores = 2
  memory = 2048


  network_adapters {
    model = "virtio"
    bridge = "vmbr0"
  }

  http_directory           = "http"
  insecure_skip_tls_verify = true

  boot_wait    = "5s"
  boot_command = [
    "<esc><wait>",
    "<esc><wait>",
    "<f6><wait>",
    "<esc><wait>",
    "autoinstall ds=nocloud-net;s=http://${ var.builderip }:{{ .HTTPPort }}/",
    "<enter>"
  ]

  ssh_timeout          = "30m"
  ssh_username         = "ubuntu"
  ssh_password         = "ubuntu"

  unmount_iso          = true
  cloud_init           = true
  cloud_init_storage_pool = "local-lvm"
}

build {
  sources = ["source.proxmox.ubuntu-2004"]
  # provisioner "ansible-local" {
  #   galaxy_file = "./ansible/requirements.yml"
  #   playbook_file = "./ansible/playbook.yml"
  # }
}
