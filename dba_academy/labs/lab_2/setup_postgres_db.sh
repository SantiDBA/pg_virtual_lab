#!/bin/bash

## Install Postgres 15
sudo bash -c 'sh /vagrant/dba_academy/labs/lab_2/_internal_postgres_db.sh'

## Change postgres password
sudo -u postgres /vagrant/dba_academy/labs/lab_2/_internal_postgres_password.sh