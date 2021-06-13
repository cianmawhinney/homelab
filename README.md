# Ansible homelab configuration

Inspired by David Stephen's [ansible-nas](https://github.com/davestephens/ansible-nas).


## Disclaimer
I don't recommend you use this playbook, this repository intended to be purely a
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


## Usage
Before running, the following is necessary:
* An an inventory file needs to be created containing the desired host
* The file `vars.yml` needs to be created to set the following variables:

```yaml
data_dir: ~/docker_data
homelab_domain: "example.com"
letsencrypt_email: "admin@example.com"
```

### Running everything

```bash
ansible-playbook -i inventory main.yml
```

