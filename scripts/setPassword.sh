#!/bin/bash
#
# Copyright (c) 2023 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at
# https://oss.oracle.com/licenses/upl.
#
# Since: November, 2016
# Author: gerald.venzl@oracle.com
# Description: Sets the password for sys, system and pdbadmin
#
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.
#

ORACLE_PWD=$1
ORACLE_SID="`grep $ORACLE_HOME /etc/oratab | cut -d: -f1`"
ORACLE_PDB="`ls -dl $ORACLE_BASE/oradata/$ORACLE_SID/*/ | grep -v pdbseed | awk '{print $9}' | cut -d/ -f6`"
ORAENV_ASK=NO
source oraenv

sqlplus / as sysdba << EOF
      ALTER USER SYS IDENTIFIED BY "$ORACLE_PWD";
      ALTER USER SYSTEM IDENTIFIED BY "$ORACLE_PWD";
      ALTER SESSION SET CONTAINER=$ORACLE_PDB;
      ALTER USER PDBADMIN IDENTIFIED BY "$ORACLE_PWD";
      exit;
EOF

