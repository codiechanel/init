# we registry:2 because we want to get the same image on restart...if you remove 2 ..it will get latest ...
# we use mount because we need a specific location instead of default

docker run -d \
  -p 5000:5000 \
  --restart=always \
  --name registry \
  -v /mnt/registry:/var/lib/registry \
  registry:2.6.1

# if you use windows....you have to use kitenatic to select which local folder it mounts to...


docker tag hello-world localhost:5000/cool-hello
docker push localhost:5000/cool-hello
docker pull localhost:5000/myfirstimage

# reset
docker stop registry && docker rm -v registry