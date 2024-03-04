. /vagrant/config/install.env

mkdir -p ${SOFTWARE_DIR}
chown -R oracle:oinstall /u01

## Oracle Installation
sudo bash -c 'sh /vagrant/scripts/setup_oracle.sh'

## Postgres packages
sh /vagrant/scripts/install_os_packages.sh

## Postgres Setup
su - postgres -c 'sh /vagrant/scripts/setup_postgres.sh'


##echo "******************************************************************************"
##echo " Download Oracle 23c free binaries" `date`
##echo "******************************************************************************"
##wget -P /vagrant https://download.oracle.com/otn-pub/otn_software/db-free/oracle-database-free-23c-1.0-1.el8.x86_64.rpm

