terraform {
  cloud {
    organization = "cianmawhinney-homelab"

    workspaces {
      name = "homelab"
    }
  }

  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "2.9.10"
    }
  }
}

resource "proxmox_vm_qemu" "actions_runner" {
  name = "actions-runner"
  desc = "Self hosted GitHub actions runner"
  target_node = var.proxmox_node

  clone = "ubuntu-2004"
  full_clone = true
  os_type = "cloud-init"

  cores = 4
  sockets = 1
  memory = 4096

  onboot = true

  disk {
    type = "scsi"
    storage = "local-zfs"
    size = "32G"
    backup = 1
    ssd = 1
  }

  network {
    model = "virtio"
    bridge = "vmbr0"
  }


  # connection {
  #   type        = "ssh"
  #   user        = self.ssh_user
  #   private_key = self.ssh_private_key
  #   host        = self.ssh_host
  #   port        = self.ssh_port
  # }
  
}
