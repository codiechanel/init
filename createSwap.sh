
# heck if existing swap 

swapon -s
free -m

# storage

df -h

# create it 
sudo dd if=/dev/zero of=/swapfile count=2048 bs=1MiB
# this one dont work
# sudo fallocate -l 4G /swapfile

# list it 
ls -lh /swapfile

# security 
sudo chmod 600 /swapfile

# enable it
sudo mkswap /swapfile
sudo swapon /swapfile

# verify 
swapon -s
free -m

# make permnent 
sudo nano /etc/fstab

# append this 
/swapfile   swap    swap    sw  0   0

# swappiness

cat /proc/sys/vm/swappiness

# if you want more ram set higher

sudo sysctl vm.swappiness=70

# permanent

sudo nano /etc/sysctl.conf
vm.swappiness = 70