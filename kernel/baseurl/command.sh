yum update

yum install gcc ncurses ncurses-devel -y

yum groupinstall "Development Tools" -y

wget https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/linux-5.8.18.tar.xz
tar -xvf linux-5.8.18.tar.xz

mv linux-5.8.18 /usr/src/
cd /usr/src/linux-5.8.18

make mrproper && make clean

cp /boot/config-`uname -r` ./.config

make menuconfig

make all

make modules_install

make install
