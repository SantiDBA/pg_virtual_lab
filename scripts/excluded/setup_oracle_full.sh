#!/bin/bash
#
# Copyright (c) 2023 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at
# https://oss.oracle.com/licenses/upl.
#
# Since: July, 2018
# Author: gerald.venzl@oracle.com
# Description: Installs Oracle database software
#
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.
#

# Abort on any error
set -Eeuo pipefail

. /vagrant/config/install.env

echo 'INSTALLER: Started up'

# get up to date
#dnf upgrade -y

echo 'INSTALLER: System updated'

# fix locale warning
dnf reinstall -y glibc-common
echo 'LANG=en_US.utf-8' >> /etc/environment
echo 'LC_ALL=en_US.utf-8' >> /etc/environment

echo 'INSTALLER: Locale set'

# set system time zone
timedatectl set-timezone "$SYSTEM_TIMEZONE"
echo "INSTALLER: System time zone set to $SYSTEM_TIMEZONE"

# Install Oracle Database preinstall and openssl packages
dnf install -y oraclelinux-developer-release-el8
dnf install -y oracle-database-preinstall-23c openssl

echo 'INSTALLER: Oracle preinstall and openssl complete'

# set environment variables
cat >> /home/oracle/.bashrc << EOF
export ORACLE_BASE=/opt/oracle
export ORACLE_HOME=/opt/oracle/product/23c/dbhomeFree
export ORACLE_SID=FREE
export PATH=\$PATH:\$ORACLE_HOME/bin
EOF

echo 'INSTALLER: Environment variables set'

# Install Oracle
# if installer doesn't exist, download it
db_installer='oracle-database-free-23c-1.0-1.el8.x86_64.rpm'
if [[ ! -f /vagrant/"${db_installer}" ]]; then
  echo 'INSTALLER: Downloading Oracle Database software'
  curl -Ls -o /vagrant/"${db_installer}" \
       https://download.oracle.com/otn-pub/otn_software/db-free/"${db_installer}"
fi

dnf -y localinstall /vagrant/"${db_installer}"

if [[ "${KEEP_DB_INSTALLER,,}" == 'false' ]]; then
  rm -f /vagrant/"${db_installer}"
fi

echo 'INSTALLER: Oracle software installed'

# Auto generate ORACLE PWD if not passed on
export ORACLE_PWD=${ORACLE_PWD:-"$(openssl rand -base64 8)1"}

# Create database
mv /etc/sysconfig/oracle-free-23c.conf /etc/sysconfig/oracle-free-23c.conf.original
cp /vagrant/ora-response/oracle-free-23c.conf.tmpl /etc/sysconfig/oracle-free-23c.conf
chmod g+w /etc/sysconfig/oracle-free-23c.conf

sed -i -e "s|###LISTENER_PORT###|$LISTENER_PORT|g" /etc/sysconfig/oracle-free-23c.conf
sed -i -e "s|###ORACLE_CHARACTERSET###|$ORACLE_CHARACTERSET|g" /etc/sysconfig/oracle-free-23c.conf
sed -i -e "s|###ORACLE_PWD###|$ORACLE_PWD|g" /etc/sysconfig/oracle-free-23c.conf
/etc/init.d/oracle-free-23c configure

chmod o+r /opt/oracle/product/23c/dbhomeFree/network/admin/tnsnames.ora

# add tnsnames.ora entry for PDB
cat >> /opt/oracle/product/23c/dbhomeFree/network/admin/tnsnames.ora << EOF
FREEPDB1 =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = $ORACLE_HOSTNAME)(PORT = $LISTENER_PORT))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = FREEPDB1)
    )
  )
EOF

echo 'INSTALLER: Database created'

# configure systemd to start Oracle instance on startup
systemctl daemon-reload
systemctl enable oracle-free-23c
systemctl start oracle-free-23c
echo 'INSTALLER: Created and enabled oracle-free-23c systemd service'

cp /vagrant/scripts/setPassword.sh /home/oracle/
chown oracle:oinstall /home/oracle/setPassword.sh
chmod u=rwx,go=r /home/oracle/setPassword.sh

echo 'INSTALLER: setPassword.sh file set up'

# run user-defined post-setup scripts
echo 'INSTALLER: Running user-defined post-setup scripts'

for f in /vagrant/userscripts/*
  do
    case "${f,,}" in
      *.sh)
        echo "INSTALLER: Running $f"
        # shellcheck disable=SC1090
        . "$f"
        echo "INSTALLER: Done running $f"
        ;;
      *.sql)
        echo "INSTALLER: Running $f"
        su -l oracle -c "echo 'exit' | sqlplus -s / as sysdba @\"$f\""
        echo "INSTALLER: Done running $f"
        ;;
      /vagrant/userscripts/put_custom_scripts_here.txt)
        :
        ;;
      *)
        echo "INSTALLER: Ignoring $f"
        ;;
    esac
  done

echo 'INSTALLER: Done running user-defined post-setup scripts'

echo "ORACLE PASSWORD FOR SYS, SYSTEM AND PDBADMIN: $ORACLE_PWD"

echo 'INSTALLER: Installation complete, database ready to use!'

echo 'Downloading JDK 17...'
wget -P /vagrant https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.rpm

echo 'Installing JDK 17...'
sudo rpm -ivh /vagrant/jdk-17_linux-x64_bin.rpm
