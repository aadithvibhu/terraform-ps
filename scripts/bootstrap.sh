#!/bin/bash
sudo yum -y update
sudo yum install -y wget vim tar ksh git
sudo amazon-linux-extras install ansible2
sudo mkdir /apps
sudo chmod 777 /apps
# you can dowload the latest playbook packages from artifactory or s3. This playbooks you can keep it in seprate repository for your development and push the latest packages always to artifactory. so that it can download the latest changes and install by ansible instead of running from local executor
