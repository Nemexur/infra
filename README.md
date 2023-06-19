# Infra

An Ansible Playbook to deploy my home servers and network setup.

## Why?

Earlier I used a TrueNAS based server in VirtualBox. It had several problems:

- Absence of SMART tests capabilities
- I am not fond of TrueNAS plugins
- Complicated GPU setup

I really like Ansible and figured why not create a 100% ansible-based server setup.
Also this project helped me to learn a lot about:

- Reverse proxy
- Cool Ansible tricks
- Docker Networking
- DHCP and DNS servers
- DNS-over-HTTPS/TLS
- Bridge
- VLAN
- Security
- Firewall
- VPN
- TLS certificates
- Cloudflare
- S.M.A.R.T
- Filesystem

## Description

The playbook is mostly being developed for personal use.
It assumes my home setup of 2 **Fedora**-based servers (38 Server):

- `Alice` - main server with the cool stuff.
- `Bravo` - handles monitoring and logs.

Everything is deployed as docker containers.

### Plans

- Add Authelia to public services
- Add Mikrotik RouterOS provisioning

### Applications

All of the values in hierarchy below are tags (**lowercased**) in [main.yml](main.yml).
Highlighted words indicate servers the tag is being used with. There are few mistakes in the structure below probably.

- [VPN](https://github.com/WeeJeWel/wg-easy) - WireGuard Easy container `Bravo`.
- Essential - essential setup like users, groups and powersaving `Alice/Bravo`.
  - Packages - install dnf packages.
- Filesystem - setup filesystem `Alice`.
  - [ZFS](https://zfsonlinux.org/) - setup pool and filesystem from SATA disks.
  - [MergerFS](https://github.com/trapexit/mergerfs) - merge separate disks and pools together.
  - [Samba](https://www.samba.org/samba/smbfs/) - setup SMB filesystem.
  - [CRON](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/cron_module.html) - create scheduled jobs.
- [Docker](https://www.docker.com/) - install and enable docker (optionally nvidia-docker2).
- Apps - available applications in the system `Alice`.
  - Network - setup and enable everything related to network.
    - [Traefik](https://traefik.io/) - web proxy and TLS certificates manager.
    - [Gluetun](https://github.com/qdm12/gluetun) - VPN client in a thin Docker container for multiple VPN providers, written in Go.
  - Containers - docker containers connected with traefik network.
    - Containers/System - everything that assists me in monitoring and controlling my services.
      - [cAdvisor](https://github.com/google/cadvisor) - analyzes resource usage and performance characteristics of running containers.
      - [Portainer](https://portainer.io/) - easily manage Docker and running containers.
      - [Diun](https://crazymax.dev/diun/) - receive notifications when a Docker image is updated on a Docker registry.
      - [Uptime Kuma](https://uptime.kuma.pet/) - a fancy self-hosted monitoring tool.
    - Containers/Media - everything to consume my media.
      - [Bazarr](https://github.com/morpheus65535/bazarr) - companion to Radarr and Sonarr for downloading subtitles.
      - [Jackett](https://github.com/Jackett/Jackett) - API Support for your favorite torrent trackers.
      - [Jellyfin](https://jellyfin.github.io) - the free software media system.
      - [Plex](https://www.plex.tv/) - you know... plex media server.
      - [Prowlarr](https://github.com/Prowlarr/Prowlarr) - indexer aggregator for Sonarr, Radarr, Lidarr, etc.
      - [Radarr](https://radarr.video/) - for organising and downloading movies.
      - [Readarr](https://readarr.com/) - for organising and downloading books.
      - [Sonarr](https://sonarr.tv/) - for downloading and managing TV episodes.
      - [Komga](https://komga.org/) - Free and open source comics/mangas media server.
      - [Tanoshi](https://github.com/faldez/tanoshi) - self-hosted web manga reader/downloader.
      - [Kaizoku](https://github.com/oae/kaizoku) - self-hosted manga downloader.
      - [Lazylibrarian](https://lazylibrarian.gitlab.io/) - follow authors and grab metadata for all your digital reading needs.
    - Containers/Services - everything that is not *Containers/Media*.
      - [Pi-Hole](https://pi-hole.net/) - protects your devices from unwanted content.
      - [Transmission](https://transmissionbt.com/) - my favorite BitTorrent client.
      - [Nextcloud](https://nextcloud.com/) - on-premise Universal File Access and sync platform.
  - Dashboard - dashboards for my applications.
    - [Homer](https://github.com/bastienwirtz/homer) - a very simple static homepage for your server.
- Monitoring - more metrics is always better.
  - [SMART](https://www.smartmontools.org/) - S.M.A.R.T monitoring of SATA disks `Home`.
  - Exporters - setup and enable metrics exporters for [Prometheus](https://prometheus.io/) `Home/Monitoring`.
    - [Node](https://github.com/prometheus/node_exporter) - exporter for hardware and OS metrics.
    - [Nvidia](https://github.com/utkuozdemir/nvidia_gpu_exporter) - Nvidia GPU exporter for prometheus, using nvidia-smi binary to gather metrics.
    - [APC UPS](https://github.com/jangrewe/apcupsd_exporter) - exporter for UPS.
    - [Pi-Hole](https://github.com/eko/pihole-exporter) - exporter for Pi-Hole.
    - [Mikrotik](https://github.com/akpw/mktxp/tree/main) - exporter for Mikrotik RouterOS devices.
  - [Prometheus](https://prometheus.io/) - an open-source systems monitoring and alerting toolkit `Monitoring`.
  - [Grafana](https://grafana.com/) - an open source analytics & monitoring solution for every database `Monitoring`.
- [Security](https://github.com/geerlingguy/ansible-role-security) - security measures for my servers `Home/Monitoring`.
  - [Security/Endlessh](https://github.com/skeeto/endlessh) - SSH tarpit that slowly sends an endless banner.

## Special thanks

- [Wolfgang](https://github.com/notthebee) for his [Infra](https://github.com/notthebee/infra) project. I was inspired by this project and "borrowed" a lot of ideas.
- [David Stephens](https://github.com/davestephens) for his [Ansible NAS](https://github.com/davestephens/ansible-nas) project. Traefik setup and dockerized applications helped me a lot.
- [Larry Smith Jr.](https://github.com/mrlesmithjr) did an amazing job with [Ansible ZFS role](https://github.com/mrlesmithjr/ansible-zfs).
- [Jeff Geerling](https://github.com/geerlingguy) for his book [Ansible for DevOps](https://www.ansiblefordevops.com/). One of the best books I read in 2022.

## TODO

### Major

- [ ] Refactor inventories/dev
- [x] Create universal role to run docker containers
- [x] Create a new role to manage users and groups
- [x] Better filesystem management
- [ ] Support Authelia

### Misc

- [ ] Refactor dashboard/homer
- [x] Refactor enabling management
- [x] Exclude open-vpn from cron docker backup
- [ ] Better project structure
- [x] Refactor grafana dashboards management (templating)
- [x] Rename home -> alice, monitoring -> bravo
- [x] yml -> yaml
- [x] Support telegram notifications

### Useful

- [ ] Add example inventory with comments
- [ ] Add CI inventory to run github-workflows
