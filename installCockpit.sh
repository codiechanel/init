sudo subscription-manager repos --enable rhel-7-server-extras-rpms
sudo yum install cockpit
sudo systemctl enable --now cockpit.socket
sudo firewall-cmd --add-service=cockpit
sudo firewall-cmd --add-service=cockpit --permanent
firewall-cmd --reload

# point your web browser to: 

https://ip-address-of-machine:9090
