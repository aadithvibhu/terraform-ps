#!/bin/bash
sudo yum -y update
sudo yum install -y wget vim tar ksh git
sudo amazon-linux-extras install ansible2
sudo yum install mysql
sudo yum install -y gcc-c++ make
curl -sL https://rpm.nodesource.com/setup_14.x | sudo -E bash -
sudo yum install -y nodejs
sudo mkdir /apps
sudo chmod 777 /apps
cd /apps && git clone https://github.com/chapagain/nodejs-mysql-crud.git && mv nodejs-mysql-crud symbiosis
cd /apps && git clone https://bitbucket.org/cloudndevops/ansible-ps.git
cd /apps/ansible-ps/playbooks && ansible-playbook symbiosis.yml
