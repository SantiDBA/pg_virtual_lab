. /vagrant/config/install.env

## Oracle Installation
sudo bash -c 'sh /vagrant/scripts/setup_oracle.sh'

## Postgres packages
sh /vagrant/scripts/install_os_packages.sh

## Postgres Setup
##su - postgres -c 'sh /vagrant/scripts/setup_postgres.sh'

## Swingbench Setup
su - oracle -c 'sh /vagrant/scripts/setup_swingbench.sh'

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

echo "******************************************************************************"
echo "** Your virtual environment is ready now.                                     "
echo "** You can find RDBMS software and scripts available on /vagrant directory.   "
echo "**                                                                            "
echo "** ENJOY IT!                                                                  "
echo "**                                                                            "
echo "** Installation ended at: " `date`
echo "******************************************************************************"
