. /vagrant/config/install_options.env

echo "******************************************************************************"
echo "Prepare yum with the latest repos." `date`
echo "******************************************************************************"
echo "nameserver 8.8.8.8" >> /etc/resolv.conf

dnf install -y dnf-utils zip unzip

## Create Oracle user
useradd -m -s /bin/bash oracle
groupadd oinstall
usermod -aG oinstall oracle

#echo "******************************************************************************"
#echo "Install Oracle prerequisite package." `date`
#echo "Not necessary, but oracle OS user has no home directory if this is not run first."
#echo "******************************************************************************"
#dnf install -y oraclelinux-developer-release-el8
#dnf install -y oracle-database-preinstall-23c

#echo "******************************************************************************"
#echo "Install Oracle RPM." `date`
#echo "******************************************************************************"
#dnf -y localinstall /vagrant/software/oracle-database-free-23c-1.0-1.el8.x86_64.rpm
#dnf update -y

echo "******************************************************************************"
echo " Download Postgres 15." `date`
echo "******************************************************************************"
dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm
dnf -qy module disable postgresql

# Check the boolean variable
if [[ "${INSTALL_POSTGRES,,}" == 'true' ]]; then
    dnf install -y postgresql15-server
    echo "export PATH=\$PATH:/usr/pgsql-15/bin" > /var/lib/pgsql/.pgsql_profile
    /usr/pgsql-15/bin/postgresql-15-setup initdb
    echo "listen_addresses = '*'" >> /var/lib/pgsql/15/data/postgresql.conf
    echo "host    all             all             samenet           scram-sha-256" >> /var/lib/pgsql/15/data/pg_hba.conf
    systemctl enable postgresql-15
    systemctl start postgresql-15
fi

echo "******************************************************************************"
echo "Firewall." `date`
echo "******************************************************************************"
systemctl stop firewalld
systemctl disable firewalld


echo "******************************************************************************"
echo "SELinux." `date`
echo "******************************************************************************"
sed -i -e "s|SELINUX=enabled|SELINUX=permissive|g" /etc/selinux/config
setenforce permissive
