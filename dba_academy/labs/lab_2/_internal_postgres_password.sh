#!/bin/bash

psql -c "ALTER USER postgres PASSWORD 'postgres';"
psql -c "create database mytestdb;" 
 
