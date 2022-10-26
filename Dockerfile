FROM python:3.8

### Build Ansible
RUN /usr/local/bin/python3 -m pip install --upgrade pip \
    && /usr/local/bin/python3 -m pip install ansible ansible-lint hvac jmespath
RUN apt-get update -y \
    && apt-get install --no-install-recommends unzip openssh-client git python3-requests python3-proxmoxer sshpass -y \
    && apt-get clean && rm -rf /var/lib/apt/lists/* 
RUN ansible-galaxy collection install community.general community.crypto community.docker community.grafana community.libvirt community.mysql community.windows freeipa.ansible_freeipa fortinet.fortimanager gluster.gluster netbox.netbox devsec.hardening  

### Build Packer
RUN wget -q https://releases.hashicorp.com/packer/1.8.3/packer_1.8.3_linux_amd64.zip \
    && unzip packer_1.8.3_linux_amd64.zip \
    && mv packer /usr/local/bin
RUN apt-get update -y \
    && apt-get install --no-install-recommends xorriso mkisofs -y \
    && apt-get clean && rm -rf /var/lib/apt/lists/* 
