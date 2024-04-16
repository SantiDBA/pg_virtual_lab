#!/bin/bash
## Setup tnsnames for future FREE DB
mkdir -p /opt/oracle/product/23c/dbhomeFree/network/admin
touch /opt/oracle/product/23c/dbhomeFree/network/admin/tnsnames.ora
chown oracle:oinstall /opt/oracle/product/23c/dbhomeFree/network/admin/tnsnames.ora
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
