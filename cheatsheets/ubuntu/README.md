# init

sudo dpkg -i ./Kitematic_X.X.X_amd64.deb

# install guest addition, guest addition requires this

sudo apt-get install linux-headers-$(uname -r) build-essential dkms