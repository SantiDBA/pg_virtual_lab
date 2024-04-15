#!/bin/bash
sudo -s
dnf install -y oraclelinux-developer-release-el8
dnf -y install oracle-database-preinstall-23c
wget -P /vagrant https://download.oracle.com/otn-pub/otn_software/db-free/oracle-database-free-23c-1.0-1.el8.x86_64.rpm
cd /vagrant
dnf -y localinstall oracle-database-free-23c-1.0-1.el8.x86_64.rpm
sudo cp -f /vagrant/ora-response/oracle-free-23c.conf.tmpl /etc/sysconfig/oracle-free-23c.conf
chmod g+w /etc/sysconfig/oracle-free-23c.conf

/etc/init.d/oracle-free-23c configure

# configure systemd to start Oracle instance on startup
systemctl daemon-reload
systemctl enable oracle-free-23c
systemctl start oracle-free-23c