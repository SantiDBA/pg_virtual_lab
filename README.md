# pg_virtual_lab
**Personal Vagrant PostgreSQL Laboratory**

## Table of contents
* [General info](#general-info)
* [Requirements](#requirements)
* [Setup](#setup)
* [Cleanup](#cleanup)

## General info
Using Vagrant, we will create two VirtualBox machines running Linux.
After installation, you will use them to experiment PostgreSQL and Oracle DB installations for playing/learning.


## Requirements

1. Install Virtualbox for your machine from: https://www.virtualbox.org/wiki/Downloads
2. Install Vagrant in your computer: https://developer.hashicorp.com/vagrant/install?product_intent=vagrant


## Setup

1. Download file: https://github.com/SantiDBA/pg_virtual_lab/archive/refs/heads/main.zip
2. Uncompress the zip file in any folder you want in your local machine.
3. Go inside the uncompressed directory.
4. Create the virtual machines with: `vagrant up`
5. Connect to the virtual machines using: `vagrant ssh primary` or `vagrant ssh standby`

Enjoy!

Environment info:

```
- Primary server:
    Hostname: primarydb
    IP: 192.168.56.140

- Standby server:
    Hostname: standbydb
    IP: 192.168.56.140
```


## Running loading on PostgreSQL with pgbench

You can run pgbench process generating loading against Postgres:

```
    vagrant ssh
    sudo -iu postgres
    psql -c "create database mytestdb;" 

    ## Initialize the database and start loading
    pgbench -i mytestdb 
    pgbench -c 10 -T 999999999 mytestdb
```

If you want to stop the data loading, please run this in your installation directory:

```
    vagrant ssh
    sudo pkill pgbench
    exit
```


## Cleanup

To remove everything from your computer, you can just destroy the virtual machine: `vagrant destroy`
