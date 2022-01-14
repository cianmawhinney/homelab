# Host Port Mappings

A list of all the ports bound to the host, all in one place.

A dynamically assigned port is denoted as 'Dynamic'


| Port    | Service     | Description                                | Proxied? (✔/✖) |
|---------|-------------|--------------------------------------------|----------------|
| 80      | Traefik     | HTTP (Redirects to HTTPS)                  | N/A            |
| 443     | Traefik     | HTTPS                                      | N/A            |
| <hr>    | <hr>        | <hr>                                       | <hr>           |
| 162     | Zabbix      | SNMP Traps                                 | ✖              |
| 1900    | Unifi       | mDNS controller discovery                  | ✖              |
| 3005    | Plex        | Plex Companion                             | ✖              |
| 3478    | Unifi       | Unifi STUN port                            | ✖              |
| 10001   | Unifi       | AP discovery                               | ✖              |
| 5000    | Registry    | Docker registry                            | ✖              |
| 5353    | Plex        | Plex Companion                             | ✖              |
| 5514    | Unifi       | Remote Syslog Port (From APs???)           | ✖              |
| 6789    | Unifi       | Mobile Throughput Speed Test               | ✖              |
| 8080    | Unifi       | Device communication (AP inform port etc.) | ✖              |
| 8324    | Plex        | Plex Companion                             | ✖              |
| 32410   | Plex        | GDM Network Discovery                      | ✖              |
| 32412   | Plex        | GDM Network Discovery                      | ✖              |
| 32413   | Plex        | GDM Network Discovery                      | ✖              |
| 32414   | Plex        | GDM Network Discovery                      | ✖              |
| Dynamic | MonitoRSS   | Web interface                              | ✔              |
| Dynamic | Netbox      | Web interface                              | ✔              |
| Dynamic | Nextcloud   | Web interface                              | ✔              |
| Dynamic | nginx-hello | Test page                                  | ✔              |
| Dynamic | Plex        | Web interface                              | ✔              |
| Dynamic | Unifi       | Web interface                              | ✔              |
| Dynamic | Vaultwarden | Web interface                              | ✔              |
| Dynamic | Zabbix      | Web interface                              | ✔              |
