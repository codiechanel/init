# init
# Note for VirtualBox users We are not producing native VirtualBox images, but you can generate your own VirtualBox image from the qcow2 images with qemu-img:

qemu-img convert -f qcow2 [filename].qcow2 -O vdi filename.vid