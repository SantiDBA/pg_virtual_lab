#!/bin/bash

LOCAL_IP_LAN=`ip -4 addr show | grep inet | awk '{print $2}' | awk -F '/' '{print $1}' | grep -v '127.0.0.1' | grep '^192'`

sudo sed -i "s/127.0.1.1 primarydb primarydb/${LOCAL_IP_LAN} primarydb primarydb/" /etc/hosts
sudo sed -i "s/127.0.1.1 standbydb standbydb/${LOCAL_IP_LAN} standbydb standbydb/" /etc/hosts

sudo bash -c 'sh /vagrant/scripts/root_setup.sh'
