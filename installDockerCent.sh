
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo \
https://download.docker.com/linux/centos/docker-ce.repo

sudo yum makecache fast
sudo yum -y install docker-ce


sudo systemctl start docker
sudo docker run hello-world

sudo systemctl enable docker

sudo usermod -aG docker ${USER}

sudo systemctl status docker

*** docker compose

sudo yum install epel-release
sudo yum install -y python-pip
sudo pip install docker-compose