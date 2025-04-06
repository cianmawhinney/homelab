# https://community.hetzner.com/tutorials/setup-your-own-scalable-kubernetes-cluster

terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.50.0"
    }
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}


###################
# Private network #
###################
resource "hcloud_network" "private_network" {
  name     = "kubernetes-cluster"
  ip_range = "10.0.0.0/16"
}

resource "hcloud_network_subnet" "private_network_subnet" {
  type         = "cloud"
  network_id   = hcloud_network.private_network.id
  network_zone = "eu-central"
  ip_range     = "10.0.1.0/24"
}


#########
# Nodes #
#########
data "cloudinit_config" "master_node" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "cloud-init.yaml"
    content_type = "text/cloud-config"

    content = yamlencode({
      packages = [
        "curl"
      ]
      write_files = [for file in local.certificates_files : {
          path = "/var/lib/rancher/k3s/server/tls/${file.file_name}"
          content = "${file.file_content}"
        }
      ]
      runcmd = [
        "apt-get update -y",
        "curl https://get.k3s.io | INSTALL_K3S_EXEC='--disable traefik' K3S_TOKEN='${random_password.k3s_token.result}' sh -"
      ]
    })
  }
}
resource "hcloud_server" "master_node" {
  name        = "master-node"
  image       = "ubuntu-24.04"
  server_type = "cax21"
  location    = "fsn1"
  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
  network {
    network_id = hcloud_network.private_network.id
    # IP Used by the master node, needs to be static
    # Here the worker nodes will use 10.0.1.1 to communicate with the master node
    ip         = "10.0.1.1"
  }

  user_data = data.cloudinit_config.master_node.rendered

  labels = {
    "k3s-control": "true"
    "k3s-worker": "true"
  }

  ssh_keys = local.ssh_key_ids

  # If we don't specify this, Terraform will create the resources in parallel
  # We want this node to be created after the private network is created
  depends_on = [hcloud_network_subnet.private_network_subnet]
}


data "cloudinit_config" "worker_nodes" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "cloud-init.yaml"
    content_type = "text/cloud-config"

    content = yamlencode({
      packages = [
        "curl"
      ]
      runcmd = [
        "apt-get update -y",
        "until curl -k https://10.0.1.1:6443; do sleep 5; done",
        "curl https://get.k3s.io | K3S_URL=https://10.0.1.1:6443 K3S_TOKEN='${random_password.k3s_token.result}' sh -"
      ]
    })
  }
}
resource "hcloud_server" "worker_nodes" {
  count = 0

  name        = "worker-node-${count.index + 1}"
  image       = "ubuntu-24.04"
  server_type = "cax21"
  location    = "fsn1"
  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
  network {
    network_id = hcloud_network.private_network.id
  }

  user_data = data.cloudinit_config.worker_nodes.rendered

  labels = {
    "k3s-worker": "true"
  }

  ssh_keys = local.ssh_key_ids

  depends_on = [hcloud_network_subnet.private_network_subnet, hcloud_server.master_node]
}


#################
# Load balancer #
#################
resource "hcloud_load_balancer" "load_balancer" {
  name               = "kubernetes-load-balancer"
  load_balancer_type = "lb11"
  location           = "fsn1"

  depends_on = [hcloud_network_subnet.private_network_subnet, hcloud_server.master_node, hcloud_server.worker_nodes]
}

resource "hcloud_load_balancer_service" "http" {
  load_balancer_id = hcloud_load_balancer.load_balancer.id
  protocol         = "tcp"
  listen_port      = 80
  destination_port = 80

  depends_on = [hcloud_load_balancer.load_balancer]
}

resource "hcloud_load_balancer_service" "https" {
  load_balancer_id = hcloud_load_balancer.load_balancer.id
  protocol         = "tcp"
  listen_port      = 443
  destination_port = 443

  depends_on = [hcloud_load_balancer.load_balancer]
}

resource "hcloud_load_balancer_network" "lb_network" {
  load_balancer_id = hcloud_load_balancer.load_balancer.id
  network_id       = hcloud_network.private_network.id

  depends_on = [hcloud_network_subnet.private_network_subnet, hcloud_load_balancer.load_balancer]
}

resource "hcloud_load_balancer_target" "load_balancer_target_worker" {
  load_balancer_id = hcloud_load_balancer.load_balancer.id

  type             = "label_selector"
  label_selector   = "k3s-worker=true"
  use_private_ip   = true

  depends_on = [hcloud_network_subnet.private_network_subnet, hcloud_load_balancer_network.lb_network, hcloud_server.worker_nodes]
}
