#!/bin/bash

dnf install -y oraclelinux-developer-release-el8
dnf -y install oracle-database-preinstall-23ai

if [ -f "/vagrant/oracle-database-free-23ai-1.0-1.el8.x86_64.rpm" ]; then
    echo "Oracle 23ai exists."
else
    echo "Downloading Oracle 23ai..."
    wget -P /vagrant https://download.oracle.com/otn-pub/otn_software/db-free/oracle-database-free-23ai-1.0-1.el8.x86_64.rpm
fi

cd /vagrant
dnf -y localinstall oracle-database-free-23ai-1.0-1.el8.x86_64.rpm
#sudo cp -f /vagrant/ora-response/oracle-free-23c.conf.tmpl /etc/sysconfig/oracle-free-23ai.conf
#chmod g+w /etc/sysconfig/oracle-free-23ai.conf

(echo "oracle"; echo "oracle";) | /etc/init.d/oracle-free-23ai configure

# configure systemd to start Oracle instance on startup
systemctl daemon-reload
systemctl enable oracle-free-23ai
systemctl start oracle-free-23ai