variable "proxmox_url" {
  default = ""
}

variable "proxmox_node" {
  default = ""
}

variable "proxmox_token_id" {
  default = ""
}

variable "proxmox_token_secret" {
  default = ""
}

source "proxmox-iso" "ubuntu-2004" {
  proxmox_url          = "${var.proxmox_url}"
  node                 = "${var.proxmox_node}"
  username             = "${var.proxmox_token_id}"
  token                = "${var.proxmox_token_secret}"

  task_timeout         = "3m"

  // skip validating the certificate on the proxmox server
  insecure_skip_tls_verify = true

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

  additional_iso_files {
    iso_storage_pool = "local"
    cd_files = ["autoinstall/*"]
    cd_label = "cidata"
    unmount = true
  }

  os = "l26"

  scsi_controller = "virtio-scsi-pci"
  disks {
    disk_size         = "8G"
    storage_pool      = "local-zfs"
    storage_pool_type = "zfspool"
    type              = "scsi"
  }

  cores = 2
  memory = 2048


  network_adapters {
    model = "virtio"
    bridge = "vmbr0"
  }

  boot_wait    = "5s"
  boot_command = [
    "<esc><wait>",
    "<esc><wait>",
    "<f6><wait>",
    "<esc><wait>",
    "autoinstall",
    "<wait><enter><enter>"
  ]

  ssh_timeout          = "30m"
  ssh_username         = "ubuntu"
  ssh_password         = "ubuntu"

  unmount_iso          = true
  cloud_init           = true
  cloud_init_storage_pool = "local-zfs"
}

build {
  sources = ["source.proxmox-iso.ubuntu-2004"]
  # provisioner "ansible-local" {
  #   galaxy_file = "./ansible/requirements.yml"
  #   playbook_file = "./ansible/playbook.yml"
  # }
}
