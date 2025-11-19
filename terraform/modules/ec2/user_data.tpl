#cloud-config
users:
  - name: ansible
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh_authorized_keys:
      - ${ssh_pubkey}

package_update: true
packages:
  - python3
  - python3-pip
runcmd:
  - [ bash, -lc, "apt-get -y install nginx || true" ]
  - [ bash, -lc, "systemctl enable nginx || true" ]

