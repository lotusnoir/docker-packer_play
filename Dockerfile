FROM python:3.8
LABEL maintainer="lotusnoir"

### Build Ansible
RUN /usr/local/bin/python3 -m pip install --upgrade pip \
    && /usr/local/bin/python3 -m pip install ansible ansible-lint hvac jmespath
RUN apt-get update -y \
    && apt-get install --no-install-recommends systemd systemd-sysv unzip openssh-client git python3-requests python3-proxmoxer sshpass xorriso mkisofs -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc /usr/share/man \
    && apt-get clean
RUN ansible-galaxy collection install community.general community.crypto community.docker community.grafana community.libvirt community.mysql community.windows freeipa.ansible_freeipa fortinet.fortimanager gluster.gluster netbox.netbox devsec.hardening  

### Build Packer
RUN wget -q https://releases.hashicorp.com/packer/1.9.4/packer_1.9.4_linux_amd64.zip \
    && unzip packer_1.9.4_linux_amd64.zip \
    && mv packer /usr/local/bin

RUN mkdir -p /lib/systemd && ln -s /lib/systemd/system /usr/lib/systemd/system;
RUN rm -f /lib/systemd/system/multi-user.target.wants/* \
    /etc/systemd/system/*.wants/* \
    /lib/systemd/system/local-fs.target.wants/* \
    /lib/systemd/system/sockets.target.wants/*udev* \
    /lib/systemd/system/sockets.target.wants/*initctl* \
    /lib/systemd/system/sysinit.target.wants/systemd-tmpfiles-setup* \
    /lib/systemd/system/systemd-update-utmp*

VOLUME [ "/tmp", "/run", "/run/lock" ]
ENTRYPOINT ["/lib/systemd/systemd", "log-level=info", "unit=sysinit.target"]
