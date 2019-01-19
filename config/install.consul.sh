#!/bin/bash

sudo apt-get update
sudo apt-get install -y unzip

CONSUL_VERSION=1.4.0

wget https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip
unzip consul_${CONSUL_VERSION}_linux_amd64.zip
sudo chmod +x consul
sudo mv consul /usr/bin/consul
