#!/bin/bash

sed -i 's/^127\.0/#127\.0/g' /etc/hosts

systemctl stop firewalld
systemctl disable firewalld
