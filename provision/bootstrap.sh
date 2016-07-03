#!/bin/bash

echo "Installing Ansible..."
apt-get install -y linux-image-extra-$(uname -r)
apt-get install -y software-properties-common
apt-add-repository ppa:ansible/ansible
apt-get update
apt-get install -y --force-yes ansible
