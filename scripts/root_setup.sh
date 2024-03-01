. /vagrant/config/install.env

sh /vagrant/scripts/install_os_packages.sh

#sh /vagrant/scripts/oracle_create_database.sh

#mkdir -p ${SOFTWARE_DIR}
#chown -R oracle:oinstall /u01

#su - oracle -c 'sh /vagrant/scripts/oracle_user_environment_setup.sh'
#su - oracle -c 'sh /vagrant/scripts/apex_software_installation.sh'
#su - oracle -c 'sh /vagrant/scripts/ords_software_installation.sh'

#sh /vagrant/scripts/oracle_service_setup.sh

su - postgres -c 'sh /vagrant/scripts/setup_postgres.sh'

echo "******************************************************************************"
echo " Download Oracle 23c free binaries" `date`
echo "******************************************************************************"
wget -P /vagrant https://download.oracle.com/otn-pub/otn_software/db-free/oracle-database-free-23c-1.0-1.el8.x86_64.rpm
