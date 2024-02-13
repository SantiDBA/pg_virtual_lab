# pg_virtual_lab
Personal Vagrant PostgreSQL Laboratory

## Table of contents
* [General info](#general-info)
* [Requirements](#requirements)
* [Setup](#setup)

## General info
Using Vagrant, we will create a VirtualBox machine running Oracle Linux and PostgreSQL.
After installation, you will have a PostgreSQL DB available for playing/learning.
By default, there will be a pgbench process generating loading against Postgres:

```
    pgbench -s 100 -c 10 -T 999999999 mytestdb
```

If you want to stop the data loading, please run this in your installation directory:

```
    vagrant ssh
    sudo pkill pgbench
    exit
```

## Requirements

Install Virtualbox for your machine from: https://www.virtualbox.org/wiki/Downloads

## Setup

1. Download file: https://github.com/SantiDBA/pg_virtual_lab/archive/refs/heads/main.zip
2. Uncompress the zip file in any folder you want in yoru lcoal machine.
3. Go inside the uncompressed directory.
4. Create virtual machine: `vagrant up`
5. Connect to postgres with any IDE (PGAdmin, DBeaver, etc.) using below information:

        HOST: 192.168.56.140
        PORT: 5432
        USER: postgres
        PASS: postgres

Enjoy!
