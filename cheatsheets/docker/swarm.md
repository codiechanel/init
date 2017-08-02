
docker swarm init  --advertise-addr 10.0.151.3
docker swarm join-token manager

docker network create --driver overlay vote