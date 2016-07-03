#!/bin/bash
echo "Adding VMs to Docker Machine"

SSH_USER=vagrant
IP_SUN=192.168.33.101
IP_MERCURY=192.168.33.102
IP_VENUS=192.168.33.103
IP_EARTH=192.168.33.104
IP_MARS=192.168.33.105

echo "Adding mercury to docker-machine, this will not be part of Swarm but host the Key/Value Store."
docker-machine create -d generic \
--generic-ssh-user $SSH_USER \
--generic-ssh-key /vagrant/.vagrant/machines/mercury/virtualbox/private_key \
--generic-ip-address $IP_MERCURY mercury

echo "Changing context to mercury"
eval $(docker-machine env mercury)
docker-machine active

echo "Running Consul image"
docker run -d -p 8500:8500 -h consul --name consul-key-value-store progrium/consul -server -bootstrap

echo "Adding sun to docker-machine as Swarm master"
docker-machine create -d generic \
--generic-ssh-user $SSH_USER \
--generic-ssh-key /vagrant/.vagrant/machines/sun/virtualbox/private_key \
--swarm --swarm-master \
--swarm-discovery="consul://$(docker-machine ip mercury):8500" \
--engine-opt="cluster-store=consul://$(docker-machine ip mercury):8500" \
--engine-opt="cluster-advertise=eth1:2376" \
--generic-ip-address $IP_SUN  sun

echo "Changing context to swarm master sun"
eval $(docker-machine env --swarm sun)
docker-machine ls

echo "Adding venus to docker-machine as Swarm node"
docker-machine create -d generic \
--generic-ssh-user $SSH_USER \
--generic-ssh-key /vagrant/.vagrant/machines/venus/virtualbox/private_key \
--swarm \
--swarm-discovery="consul://$(docker-machine ip mercury):8500" \
--engine-opt="cluster-store=consul://$(docker-machine ip mercury):8500" \
--engine-opt="cluster-advertise=eth1:2376" \
--generic-ip-address $IP_VENUS  venus

docker-machine ls

echo "Adding earth to docker-machine as Swarm node"
docker-machine create -d generic \
--generic-ssh-user $SSH_USER \
--generic-ssh-key /vagrant/.vagrant/machines/earth/virtualbox/private_key \
--swarm \
--swarm-discovery="consul://$(docker-machine ip mercury):8500" \
--engine-opt="cluster-store=consul://$(docker-machine ip mercury):8500" \
--engine-opt="cluster-advertise=eth1:2376" \
--generic-ip-address $IP_EARTH  earth

docker-machine ls

echo "Adding earth to docker-machine as Swarm node"
docker-machine create -d generic \
--generic-ssh-user $SSH_USER \
--generic-ssh-key /vagrant/.vagrant/machines/mars/virtualbox/private_key \
--swarm \
--swarm-discovery="consul://$(docker-machine ip mercury):8500" \
--engine-opt="cluster-store=consul://$(docker-machine ip mercury):8500" \
--engine-opt="cluster-advertise=eth1:2376" \
--generic-ip-address $IP_MARS  mars

docker-machine ls

#echo "Creating Overlay network ..."
#docker network create --driver overlay --subnet=192.178.0.0/16 app-overlay-net
