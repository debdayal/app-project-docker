# app-project-docker

Application stack will get deployed to a four node Swarm cluster plus one additional node for Consul Key/Value store.

> vagrant up

> vagrant ssh sun

> docker --version && docker-machine --version && docker-compose --version

> cd /vagrant/docker-swarm

> ./create-swarm-cluster.sh

> cd /vagrant/app-project/

> ./start.sh

> eval "$(docker-machine env --swarm sun)"

> docker ps -a

Scaling up a service like:

> docker-compose -p app scale user-service=2
