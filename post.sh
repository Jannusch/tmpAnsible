#!/usr/bin/env bash

echo "start pre script"
sudo apt -y update
sudo apt -y upgrade
sudo apt -y install ansible \
  docker;
cd ansible;
ansible-playbook --connection=local --inventory 127.0.0.1, studivm.yml
cd ..
sudo ./cleanup.sh
