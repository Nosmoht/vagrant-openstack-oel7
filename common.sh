#!/bin/bash

yum install -y http://repos.fedorapeople.org/repos/openstack/openstack-juno/rdo-release-juno-1.noarch.rpm
#yum install -y http://ftp-stud.hs-esslingen.de/pub/epel/7/x86_64/e/epel-release-7-2.noarch.rpm
yum update -y

sed -i 's/^127\.0/#127\.0/g' /etc/hosts

systemctl stop firewalld
systemctl disable firewalld

yum install -y ntp
systemctl enable ntpd
systemctl start ntpd
