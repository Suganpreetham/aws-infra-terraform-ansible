#!/usr/bin/env bash
set -e
cd "$(dirname "$0")/.."
# install ansible collection once
ansible-galaxy collection install amazon.aws
# run playbook using the ansible user we created in user_data
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ansible ansible/playbooks/site.yml

