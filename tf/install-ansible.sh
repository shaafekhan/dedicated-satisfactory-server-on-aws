#!/bin/bash
apt-get update
apt install software-properties-common
add-apt-repository --yes --update ppa:ansible/ansible
apt install ansible --yes