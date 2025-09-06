# pg_virtual_lab
**Personal Vagrant Laboratory for Oracle and PostgreSQL**

## Table of contents
* [General info](#general-info)
* [Requirements](#requirements)
* [Setup](#setup)
* [Enabling PostgreSQL](#enabling-postgresql)
* [DBA Academy](#dba-academy)
* [Cleanup](#cleanup)

## General info
Using Vagrant, we will create two VirtualBox machines running Linux.
This lab environment is primarily for experimenting with Oracle DB, but it can be configured to install PostgreSQL as well.

## Requirements

1. Install Virtualbox for your machine from: https://www.virtualbox.org/wiki/Downloads
2. Install Vagrant in your computer: https://developer.hashicorp.com/vagrant/install?product_intent=vagrant

## Setup

1. Clone the repository: `git clone https://github.com/SantiDBA/pg_virtual_lab.git`
2. Go inside the repository directory: `cd pg_virtual_lab`
3. Create the virtual machines: `vagrant up`
4. Connect to the virtual machines using: `vagrant ssh primary` or `vagrant ssh standby`

Enjoy!

Environment info:

```
- Primary server:
    Hostname: primarydb
    IP: 192.168.56.140

- Standby server:
    Hostname: standbydb
    IP: 192.168.56.150
```

## Enabling PostgreSQL

By default, this lab does not install PostgreSQL. To enable it, follow these steps:

1.  Open the `config/install_options.env` file.
2.  Change the value of `INSTALL_POSTGRES` from `false` to `true`.
3.  Run `vagrant provision` to apply the changes to your running VMs, or `vagrant up` if the VMs are not created yet.

This will install PostgreSQL 15.

### Running loading on PostgreSQL with pgbench

Once PostgreSQL is installed, you can run pgbench process generating loading against Postgres:

```
    vagrant ssh
    sudo -iu postgres
    psql -c "create database mytestdb;" 

    ## Initialize the database and start loading
    pgbench -i mytestdb 
    nohup pgbench -c 10 -T 999999999 mytestdb &
```

If you want to stop the data loading, please run this in your installation directory:

```
    vagrant ssh
    sudo pkill pgbench
    exit
```

## DBA Academy

This repository includes a `dba_academy` directory that contains several labs and scripts.

### Labs

The `dba_academy/labs` directory contains several labs that you can use to practice your DBA skills. Each lab has its own directory and includes a `README.md` file with instructions.

## Cleanup

To remove everything from your computer, you can just destroy the virtual machine: `vagrant destroy`

If you are using macOS, you can also use the `destroy_lab_MAC.sh` script in the `dba_academy/setup` directory.