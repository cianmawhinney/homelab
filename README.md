# IaC Homelab Configuration

[![CI](https://github.com/cianmawhinney/homelab/actions/workflows/ci.yml/badge.svg)](https://github.com/cianmawhinney/homelab/actions/workflows/ci.yml)

Inspired by David Stephen's [ansible-nas](https://github.com/davestephens/ansible-nas).


## Disclaimer
I don't recommend you use this repository, it's intended to be purely a
reference (and probably not even a very good one at that). 

The configuration sets up services the way I like them I like them. At a
miniumum, you'll need to override some variables (especially secrets/passwords).


## Services
* [Netbox](https://github.com/netbox-community/netbox-docker)
* [Nextcloud](https://github.com/nextcloud/docker)
* [Hello World Webpage](https://github.com/nginxinc/NGINX-Demos/tree/master/nginx-hello)
* [Local Docker registry](https://github.com/docker/distribution-library-image)
* [Traefik](https://github.com/traefik/traefik)
* [Unifi Controller](https://github.com/linuxserver/docker-unifi-controller)
* [Watchtower](https://github.com/containrrr/watchtower)
* [Zabbix Monitoring](https://github.com/zabbix/zabbix-docker)
* [MonitoRSS](https://github.com/synzen/MonitoRSS)
* [Vaultwarden](https://github.com/dani-garcia/vaultwarden/)
* [Transmission](https://github.com/linuxserver/docker-transmission)
* [Sonarr](https://github.com/linuxserver/docker-sonarr)
* [Prowlarr](https://github.com/linuxserver/docker-prowlarr)


## Usage
Before running, the following is necessary:
* An an inventory file needs to be created containing the desired host
* The file `vars.yml` needs to be created to set the following variables:

```yaml
data_dir: ~/docker_data
homelab_domain: "example.com"
letsencrypt_email: "admin@example.com"
media_dir: /path/to/media
```

The playbook also depends on the [geerlingguy.pip](https://github.com/geerlingguy/ansible-role-pip)
and [geerlingguy.docker](https://github.com/geerlingguy/ansible-role-docker)
roles. These can be installed by running:

```bash
ansible-galaxy install -r requirements.yml
```

### Running everything

```bash
ansible-playbook -i inventory main.yml
```

