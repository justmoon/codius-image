#!/bin/bash

# Upgrade OS
echo "Starting OS upgrade..."
sudo apt-get update
sudo apt-get dist-upgrade -y

# Install prerequisites
sudo apt-get install -y wget build-essential git

# Compile Node.js from source
cd /home/ubuntu
sudo -u ubuntu mkdir opt ; cd opt
sudo -u ubuntu wget http://nodejs.org/dist/v0.10.33/node-v0.10.33.tar.gz
echo "\
ddf4f1bc81ceda8c16953676728f4a7a1462b6bf25b97b3e70c8503307caea71\
377c5694573d09ccb54ca487910c04cef8dabf2f80a3ac7b1f76604791ea2cd7\
  node-v0.10.33.tar.gz" > node-v0.10.33.sha512sum
sha512sum -c node-v0.10.33.sha512sum || { echo 'invalid checksum' ; exit 1; }
sudo -u ubuntu tar xzvf node-v0.10.33.tar.gz
rm node-v0.10.33.tar.gz
cd node-v0.10.33
sudo -u ubuntu ./configure
sudo -u ubuntu make
sudo make install


# Add Docker repository key
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 \
                 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9

# Add Docker APT repository
sudo sh -c "echo deb https://get.docker.com/ubuntu docker main \
            > /etc/apt/sources.list.d/docker.list"

# Install latest Docker
sudo apt-get update
sudo apt-get install -y lxc-docker
