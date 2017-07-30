 docker run -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer
or 
 docker run -d -p 9000:9000 --restart unless-stopped -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer

# Alternatively, if you’re using swarm mode, you can also deploy it as a service in your cluster:

docker service create \
    --name portainer \
    --publish 9000:9000 \
    --constraint 'node.role == manager' \
    --mount type=bind,src=//var/run/docker.sock,dst=/var/run/docker.sock \
    portainer/portainer \
    -H unix:///var/run/docker.sock