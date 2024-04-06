. /vagrant/config/install_options.env

cd /home/oracle

# Check the boolean variable
if [[ "${INSTALL_SWINGBENCH,,}" == 'true' ]]; then
    echo 'Downloading SwingBench...'
    wget -P /home/oracle https://www.dominicgiles.com/site_downloads/swingbenchlatest.zip

    echo 'Installing SwingBench...'
    unzip swingbenchlatest.zip
    /home/oracle/swingbench/bin/oewizard -cl -create -cs //192.168.56.140/FREEPDB1 -u benchmark -p benchmark -scale 1 -tc 32 -dba "sys as sysdba" -dbap oracle -ts USERS
fi