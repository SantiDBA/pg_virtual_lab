#!/bin/bash
. /vagrant/config/install.env

psql -c "ALTER USER postgres PASSWORD 'postgres';"
psql -c "create database mytestdb;" 

pgbench -i mytestdb -s 100
##nohup pgbench -c 10 -T 999999999 mytestdb &
