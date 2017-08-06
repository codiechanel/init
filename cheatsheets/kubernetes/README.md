# Ubuntu version

kubectl get pods --all-namespaces

use daemon set in trafik
kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/traefik-ds.yaml
 kubectl --namespace=kube-system get pods


***

set 
/proc/sys/net/bridge/bridge-nf-call-iptables
to 1

files are in 
/etc/kubernetes

# disable firewall

systemctl stop firewalld

# Disable the Firewalld service:
systemctl mask firewalld

# reset

kubeadm reset

# secrets

kubectl port-forward $(kubectl get pods | grep traefik | awk -F' ' '{print $1}DD') 8080:8080

# connect from client 
#download conf
scp root@<master ip>:/etc/kubernetes/admin.conf .

kubectl --kubeconfig ./admin.conf get nodes