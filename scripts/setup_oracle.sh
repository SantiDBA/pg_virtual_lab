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

#echo 'INSTALLER: System updated'

# fix locale warning
dnf reinstall -y glibc-common
echo 'LANG=en_US.utf-8' >> /etc/environment
echo 'LC_ALL=en_US.utf-8' >> /etc/environment

echo 'INSTALLER: Locale set'

# set system time zone
timedatectl set-timezone "$SYSTEM_TIMEZONE"
echo "INSTALLER: System time zone set to $SYSTEM_TIMEZONE"

# Install Oracle Database preinstall and openssl packages
#dnf install -y oraclelinux-developer-release-el8
#dnf install -y oracle-database-preinstall-23ai openssl

echo 'INSTALLER: Oracle preinstall and openssl complete'

# set environment variables
#cat >> /home/oracle/.bashrc << EOF
#export ORACLE_BASE=/opt/oracle
#export ORACLE_HOME=/opt/oracle/product/23ai/dbhomeFree
#export ORACLE_SID=FREE
#export PATH=\$PATH:\$ORACLE_HOME/bin
#EOF

echo 'INSTALLER: Environment variables set'

# Download Oracle Software
# if installer doesn't exist, download it
db_installer='oracle-database-free-23ai-1.0-1.el8.x86_64.rpm'
if [[ ! -f /vagrant/"${db_installer}" ]]; then
  echo 'INSTALLER: Downloading Oracle Database software'
  curl -Ls -o /vagrant/"${db_installer}" \
       https://download.oracle.com/otn-pub/otn_software/db-free/"${db_installer}"
fi

echo 'INSTALLER: Database software downloaded'

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

echo 'Downloading JDK 17...'
wget -P /vagrant https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.rpm

echo 'Installing JDK 17...'
sudo rpm -ivh /vagrant/jdk-17_linux-x64_bin.rpm
