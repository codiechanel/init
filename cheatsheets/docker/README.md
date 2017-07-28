# Remove all containers

```bash
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
```
