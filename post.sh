#!/usr/bin/env bash

echo "start pre script"
sudo apt -y update
sudo apt -y upgrade
sudo apt -y install ansible \
  docker;
