# trouble shooting 
# https://jenakim47.tistory.com/2

yum update

yum install gcc ncurses ncurses-devel -y

yum groupinstall "Development Tools" -y

yum install wget -y
wget https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/linux-5.8.18.tar.xz
tar -xvf linux-5.8.18.tar.xz

mv linux-5.8.18 /usr/src/
cd /usr/src/linux-5.8.18

yum -y install openssl-devel

yum -y install elfutils-libelf-devel

make mrproper && make clean

cp /boot/config-`uname -r` ./.config

make menuconfig

make all

make modules

make modules_install

make install

grep ^menuentry /boot/grub2/grub.cfg | cut -d "'" -f2
# /boot/grub2/grub.cfg 파일이 없을경우 경로를 /boot/efi/EFI/centos/grub.cfg로 진행

grub2-set-default "CentOS Linux (4.4.214-1.el7.elrepo.x86_64) 7 (Core)" 

grub2-editenv list

## gcc upgrade
yum install centos-release-scl -y

yum-config-manager --enable rhel-server-rhscl-7-rpms

yum install devtoolset-8 -y

scl enable devtoolset-8 bash
