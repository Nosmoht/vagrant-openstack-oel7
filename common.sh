#!/bin/bash

yum install -y http://ftp-stud.hs-esslingen.de/pub/epel/7/x86_64/e/epel-release-7-2.noarch.rpm
yum update -y

sed -i 's/^127\.0/#127\.0/g' /etc/hosts

systemctl stop firewalld
systemctl disable firewalld
