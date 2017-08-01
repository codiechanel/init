# Binary (woring on ubuntu)

https://github.com/openshift/origin/releases/download/v3.6.0/openshift-origin-server-v3.6.0-c4dd4cf-linux-64bit.tar.gz

/etc/docker/daemon.json
should have this file
{
  "insecure-registries" : ["myregistrydomain.com:5000"]
}

# init

sudo docker run -d --name "origin" \
        --privileged --pid=host --net=host \
        -v /:/rootfs:ro -v /var/run:/var/run:rw -v /sys:/sys -v /sys/fs/cgroup:/sys/fs/cgroup:rw \
        -v /var/lib/docker:/var/lib/docker:rw \
        -v /var/lib/origin/openshift.local.volumes:/var/lib/origin/openshift.local.volumes:rslave \ 
        openshift/origin start

        or

        docker run -d --name "origin"   --privileged --pid=host --net=host  -v /var/log:/var/log -v /:/rootfs:ro -v /var/run:/var/run:rw -v /sys:/sys -v /sys/fs/cgroup:/sys/fs/cgroup:rw   -v /var/lib/docker:/var/lib/docker:rw   -v /var/lib/origin/openshift.local.volumes:/var/lib/origin/openshift.local.volumes:rslave  openshift/origin start 

        or 

        docker run -d --name "origin"  --privileged --pid=host --net=host  -v /var/log:/var/log -v /:/rootfs:ro -v /var/run:/var/run:rw -v /sys:/sys -v /sys/fs/cgroup:/sys/fs/cgroup:rw   -v /var/lib/docker:/var/lib/docker:rw   -v /var/lib/origin/openshift.local.volumes:/var/lib/origin/openshift.local.volumes:rslave  openshift/origin start --public-master=https://apps.192.168.1.9.xip.io:8443

# install registry 
sudo docker exec -it origin bash

oc login -u system:admin -n default --config=/var/lib/origin/openshift.local.config/master/admin.kubeconfig

export KUBECONFIG=/var/lib/origin/openshift.local.config/master/admin.kubeconfig
export CURL_CA_BUNDLE=/var/lib/origin/openshift.local.config/master/ca.crt
oadm registry -n default --config=/var/lib/origin/openshift.local.config/master/admin.kubeconfig

# dry run check if its created
 oadm registry --dry-run


 # get ip 
 oc get svc/docker-registry -o yaml | grep clusterIP:
  #delete
 oc delete svc/docker-registry dc/docker-registry


You should be able to start OpenShift with a --public-master=https://cevm.local:8443 arg to tell it where to direct external clients

you could append params to openshif

--public-master=https://192.168.56.101:8443

--listen=https://192.168.156.101:8080
--listen=https://192.168.1.10:8080

# you can now use kubectl commands

kubectl config view

# notes

i can ssh to 192.168.1.10 which is the bridge vbox

origin can only bind on the bride

kubectl proxy --address=192.168.1.10 --port=8080

or 

kubectl proxy --address=0.0.0.0 --port=8080

# public master

 docker run -d --name "origin"   --privileged --pid=host --net=host  -v /:/rootfs:ro -v /var/run:/var/run:rw -v /sys:/sys -v /sys/fs/cgroup:/sys/fs/cgroup:rw   -v /var/lib/docker:/var/lib/docker:rw   -v /var/lib/origin/openshift.local.volumes:/var/lib/origin/openshift.local.volumes:rslave  openshift/origin start --public-master=https://192.168.1.10:8443


# admin mode

oc login -u system:admin


##### NOTES you may have skipped this

 yum install wget git net-tools bind-utils iptables-services bridge-utils bash-completion kexec-tools sos psacct

 yum update

 Edit the /etc/sysconfig/docker file and add --insecure-registry 172.30.0.0/16 to the OPTIONS parameter. For example:

OPTIONS='--selinux-enabled --insecure-registry 172.30.0.0/16'




# registry 

oadm registry --config=admin.kubeconfig --service-account=registry

# firewall

firewall-cmd --zone=public --add-port=8443/tcp --permanent
firewall-cmd --zone=public --add-port=443/tcp --permanent
firewall-cmd --reload
or
firewall-cmd --zone=trusted --change-interface=docker0

or stop it
sudo systemctl stop firewalld
sudo systemctl start firewalld



# this is the kube master...
oc describe svc/kubernetes
 172.30.0.1

 # create router

 oc adm policy add-scc-to-user hostnetwork system:serviceaccount:default:router
 oadm policy add-cluster-role-to-user \
    cluster-reader \
    system:serviceaccount:default:router

 oc adm router <router_name> --replicas=<number> --service-account=router

 # login
 oc login
 oc new-project test
 oc new-app openshift/deployment-example
 oc status


 # templates
cd ~
git clone https://github.com/openshift/openshift-ansible
IMAGESTREAMDIR=~/openshift-ansible/roles/openshift_examples/files/examples/v1.1/image-streams; \
    DBTEMPLATES=~/openshift-ansible/roles/openshift_examples/files/examples/v1.1/db-templates; \
    QSTEMPLATES=~/openshift-ansible/roles/openshift_examples/files/examples/v1.1/quickstart-templates

    oc create -f $IMAGESTREAMDIR/image-streams-rhel7.json -n openshift
    oc create -f $DBTEMPLATES -n openshift
    oc create -f $QSTEMPLATES -n openshift

# Trouble shooting

ip a
ip route

# app mgt

oc status -v
oc logs -f bc/ruby-ex
oc project <name>
# use a label so you can delete them all at once
 oc delete all -l name=<name>


oc new-app openshift/deployment-example -l name=<name>
oc new-app openshift/nodejs-010-centos7~https://github.com/openshift/nodejs-ex.git -l name=<name>
oc new-app centos/ruby-22-centos7~https://github.com/openshift/ruby-ex.git
oc new-app centos/ruby-22-centos7~https://github.com/codiechanel/ruby-ex.git


# Verify NetworkManager is configured to use dnsmasq:
sudo vi /etc/NetworkManager/NetworkManager.conf
[main]
dns=dnsmasq

# Configure dnsmasq to use the Virtual Network router for example.com:
sudo vi /etc/NetworkManager/dnsmasq.d/libvirt_dnsmasq.conf
server=/example.com/192.168.55.1

# network manager
service NetworkManager status
ls /etc/NetworkManager/*

# ip tables
## delete all rules
iptables -F
## show rules
iptables -S

# notes

etc/resolve is copied from host to open shift origin


# registry delete 
osc delete replicationcontrollers docker-registry-1
osc delete pods -l deployment=docker-registry-1
osc delete service docker-registry
osc delete deploymentconfig docker-registry

# notes
OpenShift Origin then inserts one DNS value into the pods (above the node’s nameserver values). That value is defined in the /etc/origin/node/node-config.yaml file by the dnsIP parameter, which by default is set to the address of the host node because the host is using dnsmasq.

 # reset 
rm -rf /var/lib/origin

# diagostic pod

oc adm diagnostics
oc adm diagnostics NodeConfigCheck UnitStatus
oadm diagnostics DiagnosticPod
ps -lef | grep dnsmasq

# resolve
search kubernetes.default.svc.cluster.local default.svc.cluster.local svc.cluster.local cluster.local

# end points 
oc get endpoints -n default kubernetes

# dig 
yum install bind-utils

# notes

Make sure that in /etc/sysconfig/network-scripts/ifcfg-eth0, the variable PEERDNS is set to no so that /etc/resolv.conf doesn't get overwritten on each reboot. Reboot the machines and check that /etc/resolv.conf hasn't been overwritten.

# cmds

oc get service kubernetes -n default -o yaml
oc get endpoints kubernetes -n default -o yaml

 oc cluster up --public-hostname 192.168.1.9

# Enabling and Disabling SELinux
# not in ubuntu
 /usr/sbin/getenforce
 /usr/sbin/sestatus

 grep -e 'vmx' /proc/cpuinfo

 /etc/sysconfig/docker
 --insecure-registry 172.30.0.0/16

 --public-hostname=192.168.1.7