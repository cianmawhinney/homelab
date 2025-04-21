variable "environment" {
  description = "The name of the environment these resouces are being deployed to"
  type        = string
  default     = "dev"
}

variable "cluster_ssh_public_key" {
  description = "Main SSH public key for cluster"
  type        = string
  default     = null
  sensitive   = false
}

variable "cluster_ssh_private_key" {
  description = "Main SSH private key for cluster"
  type        = string
  default     = null
  sensitive   = true
}


variable "ssh_keys" {
  default = [
    {
      "name" : "CIAN-X1YOGA (TCD email)",
      "public_key" : "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDYiNLw++V2Ajl1h8FGvfpGNIOGnuhdunz1mcJ5qZt1U/URZ93BI6coN38p6e6CPEkkUwhkq3cVhi5EfBCh6IUh0Tb8gHZ0fs5FCnMjRGapjFFGMjfGcyRWCOGvPDrOnztSO+SU4wOf18gAoMmdG8fgCiv4sJsGu1Pb7W26VYNySvfVRcvFyXQI9HhvjFvP2xJ0gDNiT0IPYrnS3wHyM5G9RuO5Mmz5AppmlHq19poYm5Tmb6N7Jf1LDAl/73B77YKFRCI3t7z5ojxZdsdbDq14O3dGxWJ95S5PgK0lXFCrgDkwRXKqW6cyAhQ5ccryn6LSMgRSmDqLNEUaOYXFxyLvYXRigXe0VDZGTMNJpIfOqdcGc25TRce5jTrf5OM/m6zBnbtiBcqWyCiNkXKeDxZ1MifUONB+j3zcnWJopLCTl8k3diKghquja6mQMxIaRwjwUnXOQbzSGQWd7jnON0sprK9RTJ47wQbTY9sH3VSFe2YIv0/NwThYiwb0SCDZaZbltiGhFEhVkJeJhtEHANzRc2ojT0LRUNPgXqJdpwBDI7gfkgZ1n9jkMwNZTC7VTNuM6kldWc3yyDnw9XPehyVvt/MBhD7W9U5qOc2Tbq+lD/GhW/7XYC1MI6vt95QLBT5QFkj1mKa2XUGaSMYHiXj5p2wtCTwdSDBpNIm8ZMeb0Q== mawhinnc@tcd.ie"
    },
    {
      "name" : "CIAN-DESKTOP",
      "public_key" : "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIaexsTtRC/TcLeoyZW/IVzpgVcgJZi4L7g29S7RvegO cianmawhinney@gmail.com"
    }
  ]
}


resource "digitalocean_ssh_key" "personal_laptop_key" {
  name       = "CIAN-X1YOGA (TCD email)"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDYiNLw++V2Ajl1h8FGvfpGNIOGnuhdunz1mcJ5qZt1U/URZ93BI6coN38p6e6CPEkkUwhkq3cVhi5EfBCh6IUh0Tb8gHZ0fs5FCnMjRGapjFFGMjfGcyRWCOGvPDrOnztSO+SU4wOf18gAoMmdG8fgCiv4sJsGu1Pb7W26VYNySvfVRcvFyXQI9HhvjFvP2xJ0gDNiT0IPYrnS3wHyM5G9RuO5Mmz5AppmlHq19poYm5Tmb6N7Jf1LDAl/73B77YKFRCI3t7z5ojxZdsdbDq14O3dGxWJ95S5PgK0lXFCrgDkwRXKqW6cyAhQ5ccryn6LSMgRSmDqLNEUaOYXFxyLvYXRigXe0VDZGTMNJpIfOqdcGc25TRce5jTrf5OM/m6zBnbtiBcqWyCiNkXKeDxZ1MifUONB+j3zcnWJopLCTl8k3diKghquja6mQMxIaRwjwUnXOQbzSGQWd7jnON0sprK9RTJ47wQbTY9sH3VSFe2YIv0/NwThYiwb0SCDZaZbltiGhFEhVkJeJhtEHANzRc2ojT0LRUNPgXqJdpwBDI7gfkgZ1n9jkMwNZTC7VTNuM6kldWc3yyDnw9XPehyVvt/MBhD7W9U5qOc2Tbq+lD/GhW/7XYC1MI6vt95QLBT5QFkj1mKa2XUGaSMYHiXj5p2wtCTwdSDBpNIm8ZMeb0Q== mawhinnc@tcd.ie"
}

resource "digitalocean_ssh_key" "personal_desktop_key" {
  name       = "CIAN-DESKTOP"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIaexsTtRC/TcLeoyZW/IVzpgVcgJZi4L7g29S7RvegO cianmawhinney@gmail.com"
}

resource "digitalocean_tag" "production" {
  name = "prod"
}

resource "hcloud_ssh_key" "personal_laptop_key" {
  name       = "CIAN-X1YOGA (TCD email)"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDYiNLw++V2Ajl1h8FGvfpGNIOGnuhdunz1mcJ5qZt1U/URZ93BI6coN38p6e6CPEkkUwhkq3cVhi5EfBCh6IUh0Tb8gHZ0fs5FCnMjRGapjFFGMjfGcyRWCOGvPDrOnztSO+SU4wOf18gAoMmdG8fgCiv4sJsGu1Pb7W26VYNySvfVRcvFyXQI9HhvjFvP2xJ0gDNiT0IPYrnS3wHyM5G9RuO5Mmz5AppmlHq19poYm5Tmb6N7Jf1LDAl/73B77YKFRCI3t7z5ojxZdsdbDq14O3dGxWJ95S5PgK0lXFCrgDkwRXKqW6cyAhQ5ccryn6LSMgRSmDqLNEUaOYXFxyLvYXRigXe0VDZGTMNJpIfOqdcGc25TRce5jTrf5OM/m6zBnbtiBcqWyCiNkXKeDxZ1MifUONB+j3zcnWJopLCTl8k3diKghquja6mQMxIaRwjwUnXOQbzSGQWd7jnON0sprK9RTJ47wQbTY9sH3VSFe2YIv0/NwThYiwb0SCDZaZbltiGhFEhVkJeJhtEHANzRc2ojT0LRUNPgXqJdpwBDI7gfkgZ1n9jkMwNZTC7VTNuM6kldWc3yyDnw9XPehyVvt/MBhD7W9U5qOc2Tbq+lD/GhW/7XYC1MI6vt95QLBT5QFkj1mKa2XUGaSMYHiXj5p2wtCTwdSDBpNIm8ZMeb0Q== mawhinnc@tcd.ie"
  labels = {
    "owner" : "cian"
  }
}

resource "hcloud_ssh_key" "personal_desktop_key" {
  name       = "CIAN-DESKTOP"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIaexsTtRC/TcLeoyZW/IVzpgVcgJZi4L7g29S7RvegO cianmawhinney@gmail.com"
  labels = {
    "owner" : "cian"
  }
}

module "kube-hetzner" {
  providers = {
    hcloud = hcloud
  }
  source = "kube-hetzner/kube-hetzner/hcloud"

  hcloud_token = var.hcloud_token

  cluster_name = "k3s-${var.environment}"

  ssh_public_key       = var.cluster_ssh_public_key
  ssh_private_key      = var.cluster_ssh_private_key
  ssh_hcloud_key_label = "owner=cian"

  network_region = "eu-central"

  control_plane_nodepools = [
    {
      name        = "control-plane-nbg1",
      server_type = "cax21",
      location    = "nbg1",
      labels      = [],
      taints      = [],
      count       = 1
    }
  ]
  agent_nodepools = []

  load_balancer_type     = "lb11"
  load_balancer_location = "nbg1"

  ingress_controller        = "traefik"
  ingress_replica_count     = 0 # autoscale the number of replicas
  traefik_autoscaling       = true
  traefik_redirect_to_https = true

  # Since there is only 1 node, we can't afford losing a node when performing updates.
  automatically_upgrade_os = false
  system_upgrade_use_drain = true

  dns_servers = [
    "1.1.1.1",
    "2606:4700:4700::1111",
  ]
}
