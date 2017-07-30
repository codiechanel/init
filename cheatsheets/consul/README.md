# running consule

edit /etc/dhcp/dhclient.conf

# add consul dns
prepend domain-name-servers x.x.x.x, y.y.y.y;

# we cnt edit /etc/resolv.conf directly
you should edit /etc/resolv.conf

nameserver 127
and docker bridge ip 

# Start Consul

```
docker run -d -p 8500:8500 -p 172.17.0.1:53:8600/udp -p 8400:8400 gliderlabs/consul-server -node myconsul -bootstrap
```

# Start Registrator

```
docker run -d -v /var/run/docker.sock:/tmp/docker.sock --net=host gliderlabs/registrator -internal consul://localhost:8500
```

# Web UI 

```
http://consul:8500
```

# Nginx conf
```
http {
 resolver 172.17.0.1;
  resolver_timeout 10s;
map $host $subdomain {
    ~^(?<sub>.+)\.[^\.]+\.[^\.]+$ $sub;
}

server {
listen 80 default_server;
 server_name  ~([^.]+)\.jscode\.info$;
    set $subdomain $1;
    location / {
        if ($subdomain) {

            proxy_pass http://$subdomain.service.consul;


        }
    }
}
```

# Deploy normally but add ENV variables like:

```
docker run -d  -p :80 -e "SERVICE_80_NAME=fourth" -e "SERVICE_80_ID=fourth"  --name=fourth bitnami/apache
```

or with health checks

```
docker run -d  -p :80 -e "SERVICE_80_NAME=second" -e "SERVICE_80_ID=second" -e "SERVICE_80_CHECK_HTTP=true" -e "SERVICE_80_CHECK_HTTP=/" --name=second nginx
```

# The SERVICE_80_NAME is what matters here. You can have the same service name if you wana load balance, but service id should be unique.