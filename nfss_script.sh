#!/bin/bash
echo "Create directories for our sharing:"

mkdir /home/vagrant/share
mkdir /home/vagrant/share/upload

echo "Create nfs exports:"

sudo echo "/home/vagrant/share/ 192.168.100.41(sync,ro,root_squash,secure)" > /etc/exports
sudo echo "/home/vagrant/share/upload/ 192.168.100.41(sync,rw,root_squash,secure)" >> /etc/exports

echo "Enable autoreload for our services and start them:"

sudo systemctl enable nfs
sudo systemctl enable firewalld
sudo systemctl start nfs
sudo systemctl start firewalld

echo "Configure firewall:"

sudo firewall-cmd --zone=public --add-service mountd --permanent
sudo firewall-cmd --zone=public --add-service nfs --permanent
sudo firewall-cmd --zone=public --add-service rpc-bind --permanent
sudo firewall-cmd --reload

echo "Create some files in uor share for testing"

sudo touch /home/vagrant/share/file{1..6}

echo "Change owner and group for our server share to access for vagrant user:"

sudo chown -R vagrant:vagrant /home/vagrant/share

