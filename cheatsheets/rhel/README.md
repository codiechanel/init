# add name servers

/etc/sysconfig/network-scripts/ifcfg-enp0s3

DNS1=8.8.8.8
DNS2=8.8.4.4
# Note this was set to no
ONBOOT=yes  

# troubleshooting

cd /etc/sysconfig/network-scripts
grep ^DEVICE ifcfg-*
sudo systemctl status network

# use nmcli 

nmcli device connect enp0s8

# firewall rules

 iptables -L
 iptables -L -nv
# service
 service --status-all


 # dns mas
 systemctl enable dnsmasq