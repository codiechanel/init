subscription-manager register
subscription-manager list --available    
#Find valid RHEL pool ID
subscription-manager attach --pool=pool_id

subscription-manager repos --enable=rhel-7-server-rpms
subscription-manager repos --enable=rhel-7-server-extras-rpms
subscription-manager repos --enable=rhel-7-server-optional-rpms

yum install docker device-mapper-libs device-mapper-event-libs
or 
yum install docker-latest device-mapper-libs device-mapper-event-libs

systemctl start docker.service
systemctl enable docker.service
systemctl status docker.service