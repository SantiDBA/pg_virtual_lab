#!/bin/bash
echo "Installing VirtualBox..."
brew install --cask virtualbox
echo "Installing VirtualBox... DONE"
echo "Installing Vagrant..."
brew tap hashicorp/tap
brew install hashicorp/tap/hashicorp-vagrant
echo "Installing Vagrant... DONE"
echo "Start the Virtual Machine..."
vagrant up