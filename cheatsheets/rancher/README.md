# Create

```

docker-machine create -d virtualbox --virtualbox-boot2docker-url https://releases.rancher.com/os/latest/rancheros.iso rancherOS
```

Docker is up and running!
To see how to connect your Docker Client to the Docker Engine running on this virtual machine, run: 
```
docker-machine.exe env rancherOS
```
# This is the preferred method
```
docker-machine ssh rancherOS
```

# Start / stop 

```
docker-machine start rancherOS
```

# Run the Rancher server 

```
sudo docker run -d --restart=unless-stopped -p 8080:8080 rancher/server:stable
```