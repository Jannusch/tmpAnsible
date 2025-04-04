#!/usr/bin/env bash

echo "start pre script"
sudo apt -y update
sudo apt -y upgrade
sudo apt -y install ansible \
  docker;
cd ansible;
ansible-playbook --connection=local --inventory 127.0.0.1, studivm.yml

rm -rf ../tmpAnsible
rm $HOME/workspaces/import.sh

rm $HOME/script.sh

echo "==> Remove user veins from password-less sudoers"
rm /etc/sudoers.d/veins

echo "==> Clean apt"
apt-get -y autoremove --purge
apt-get -y clean
apt-get -y autoclean

echo "==> Clean history"
unset HISTFILE
rm -f /root/.bash_history
rm -f /root/.zsh_history
rm -f /home/*/.bash_history
rm -f /home/*/.zsh_history

echo "==> Clean /tmp"
rm -rf /tmp/*

echo "==> Clean logs"
find /var/log -type f | while read f; do echo -ne '' > "${f}"; done;

echo '==> Zero out root'
dd if=/dev/zero of=/EMPTY bs=1M || echo "This command was expected to fail. Continuing."
rm -f /EMPTY

echo '==> Sync'
sync
