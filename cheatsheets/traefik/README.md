# init

traefik:
  image: traefik
  command: --web --docker --docker.domain=docker.localhost --logLevel=DEBUG
  ports:
    - "80:80"
    - "8080:8080"
    - "443:443"
  volumes:
    - /var/run/docker.sock:/var/run/docker.sock
    - /dev/null:/traefik.toml

machine:
  image: nginx
  labels:
    - "traefik.backend=web"
    - "traefik.frontend.rule=Host:apps.192.168.1.11.nip.io"

