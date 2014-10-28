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
| hostname      | ip address | Openstack Role  | Services 		       |
| ------------- | ---------- | --------------- | --------------------- |
| os-db-01		| 10.0.0.12  | Database node   | MariaDB  			   |
| os-ctrl-01	| 10.0.0.11  | Controller node | Keystone and RabbitMQ |
| os-neutron-01	| 10.0.0.21  | Network         | Neutron               |
| os-nova-01    | 10.0.0.31  | Compute		   | Nova				   |

Open Issues
-----------
1. Creation of RabbitMQ users sometimes fails. Restart RabbitMQ service and provision again works.
2. Creation of Tenant sometimes fails and a restart of openstack-keystone shows "Permission denied" error. Kill keystone process and start again works.

Notes
-----
To change hostnames or ip addresses edit the following files:
* Vagrantfile
* ansible/hosts
