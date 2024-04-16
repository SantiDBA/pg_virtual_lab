#!/bin/bash
echo "Installing VirtualBox..."
brew install --cask virtualbox
echo "Installing VirtualBox... DONE"
echo "Installing Vagrant..."
brew tap hashicorp/tap
brew install hashicorp/tap/hashicorp-vagrant
echo "Installing Vagrant... DONE"
echo "Downloading Virtual Machine..."
wget --output-document=syscon_lab.zip https://github.com/SantiDBA/pg_virtual_lab/archive/refs/heads/main.zip
echo "Downloading Virtual Machine... DONE"
echo "Unzipin labs..."
unzip syscon_lab.zip
cd pg_virtual_lab-main
vagrant up
