
# firewall

firewall-cmd --zone=public --add-port=8443/tcp --permanent
firewall-cmd --zone=public --add-port=443/tcp --permanent
firewall-cmd --reload
or
firewall-cmd --zone=trusted --change-interface=docker0

or stop it
sudo systemctl stop firewalld
sudo systemctl start firewalld
