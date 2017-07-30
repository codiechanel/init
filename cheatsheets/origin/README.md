# init

sudo docker run -d --name "origin" \
        --privileged --pid=host --net=host \
        -v /:/rootfs:ro -v /var/run:/var/run:rw -v /sys:/sys -v /sys/fs/cgroup:/sys/fs/cgroup:rw \
        -v /var/lib/docker:/var/lib/docker:rw \
        -v /var/lib/origin/openshift.local.volumes:/var/lib/origin/openshift.local.volumes:rslave \ 
        openshift/origin start

        or

        docker run -d --name "origin"   --privileged --pid=host --net=host  -v /var/log:/var/log -v /:/rootfs:ro -v /var/run:/var/run:rw -v /sys:/sys -v /sys/fs/cgroup:/sys/fs/cgroup:rw   -v /var/lib/docker:/var/lib/docker:rw   -v /var/lib/origin/openshift.local.volumes:/var/lib/origin/openshift.local.volumes:rslave  openshift/origin start 

# install registry 
sudo docker exec -it origin bash

oc login -u system:admin -n default --config=/var/lib/origin/openshift.local.config/master/admin.kubeconfig

export KUBECONFIG=/var/lib/origin/openshift.local.config/master/admin.kubeconfig
export CURL_CA_BUNDLE=/var/lib/origin/openshift.local.config/master/ca.crt
oadm registry -n default --config=/var/lib/origin/openshift.local.config/master/admin.kubeconfig


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


 # reset 
rm -rf /var/lib/origin

# registry 

oadm registry --config=admin.kubeconfig --service-account=registry

# firewall

firewall-cmd --zone=public --add-port=8443/tcp --permanent
firewall-cmd --reload

# diagostic pod

oadm diagnostics DiagnosticPod

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