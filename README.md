vagrant-openstack-juno
======================
Vagrant file to setup a multi node Openstack Environment.

Installation
------------
```sh
git clone https://github.com/Nosmoht/vagrant-openstack-oel7.git <dir>
cd <dir>
git submodule foreach git pull origin master
vagrant up
```

Hosts
-----
* os-db-01		Database node running MariaDB
* os-ctrl-01		Controller node running Openstack Keystone and RabbitMQ
* os-neutron-01	Network node running Openstack Neutron service
* os-nova-0[1:2]	Compute node running Openstack Nova service

Open Issues
-----------
1. Creation of RabbitMQ users sometimes fails. Restart RabbitMQ service and provision again works.
2. Creation of Tenant sometimes fails and a restart of openstack-keystone shows "Permission denied" error. Kill keystone process and start again works.

Notes
-----
To change hostnames or ip addresses edit the following files:
* Vagrantfile
* ansible/hosts
