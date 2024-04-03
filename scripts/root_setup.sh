. /vagrant/config/install.env

mkdir -p ${SOFTWARE_DIR}
chown -R oracle:oinstall /u01

# set environment variables
cat >> /home/oracle/.bashrc << EOF
export ORACLE_BASE=/opt/oracle
export ORACLE_HOME=/opt/oracle/product/23c/dbhomeFree
export ORACLE_SID=FREE
export PATH=\$PATH:\$ORACLE_HOME/bin
EOF

chown oracle:oinstall /home/oracle/.bashrc

## Oracle Installation
sudo bash -c 'sh /vagrant/scripts/setup_oracle.sh'

## Postgres packages
sh /vagrant/scripts/install_os_packages.sh

## Postgres Setup
su - postgres -c 'sh /vagrant/scripts/setup_postgres.sh'

## Swingbench Setup
su - oracle -c 'sh /vagrant/scripts/setup_swingbench.sh'

##echo "******************************************************************************"
##echo " Download Oracle 23c free binaries" `date`
##echo "******************************************************************************"
wget -P /vagrant https://download.oracle.com/otn-pub/otn_software/db-free/oracle-database-free-23c-1.0-1.el8.x86_64.rpm

echo "******************************************************************************"
echo "** Your virtual environment is ready now.                                     "
echo "** You can find RDBMS software and scripts available on /vagrant directory.   "
echo "**                                                                            "
echo "** ENJOY IT!                                                                  "
echo "******************************************************************************"
