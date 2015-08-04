#!/bin/bash -e

echo "deb http://download.virtualbox.org/virtualbox/debian trusty contrib" | sudo tee -a /etc/apt/sources.list
wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y --force-yes linux-headers-$(uname -r) build-essential virtualbox-4.3 dkms
wget http://download.virtualbox.org/virtualbox/4.3.10/Oracle_VM_VirtualBox_Extension_Pack-4.3.10-93012.vbox-extpack
sudo VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-4.3.10-93012.vbox-extpack

sudo apt-get install -y unzip
wget https://dl.bintray.com/mitchellh/packer/packer_0.8.2_linux_amd64.zip
unzip packer_0.8.2_linux_amd64.zip
sudo cp packer* /usr/local/bin/

git clone https://github.com/tsuru/tsuru-packer.git
cd tsuru-packer
make setup
packer build -machine-readable tsuru-stable.json