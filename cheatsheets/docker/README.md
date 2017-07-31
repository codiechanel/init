# Remove all containers

```
docker stop $(docker ps -a -q)
docker start  $(docker ps -a -q)
docker rm $(docker ps -a -q)
```

# All images

```
docker images -a
```

# Service control

```
sudo systemctl disable docker
sudo systemctl restart docker
sudo systemctl status docker 

systemctl enable docker.service
sudo service docker status
sudo service docker stop
sudo service docker start
```

# Run

```
docker run -it --rm --name my-running-script mhart/alpine-node sh
```

# With local mount

```
docker run -it --rm --name my-running-script  -v "local:/usr/src/app" -w /usr/src/app mhart/alpine-node sh
```


# Workaround get tree view images

```
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock nate/dockviz images -t
```

# tricks

docker run --help | grep dns