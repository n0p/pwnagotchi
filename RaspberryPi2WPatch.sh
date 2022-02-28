#!/bin/bash

#Working numpy #1045
#sudo pip3 uninstall numpy
#sudo pip3 install numpy==1.20.2

##Updates
#apt-get update && apt-get upgrade

#Dependancies
sudo apt install raspberrypi-kernel-headers git libgmp3-dev gawk qpdf bison flex make autoconf libtool texinfo

#clone git
git clone https://github.com/DrSchottky/nexmon.git

#go to dir
cd ~/nexmon/

#isl-0.10 install
cd ~/nexmon/buildtools/isl-0.10 
./configure 
make 
make install 
ln -s /usr/local/lib/libisl.so /usr/lib/arm-linux-gnueabihf/libisl.so.10


#isl-0.10 mpfr-3.1.4
cd ~/nexmon/buildtools/mpfr-3.1.4 
autoreconf -f -i
./configure
make
make install
ln -s /usr/local/lib/libmpfr.so /usr/lib/arm-linux-gnueabihf/libmpfr.so.4

#Set up build env
cd ~/nexmon
source setup_env.sh
make


#install rpi02w fw
cd ~/nexmon/patches/bcm43436b0/9_88_4_65/nexmon/
make
make backup-firmware
make install-firmware

#I dont think this is necessary as we only want the firmware from Nexmon but let me knw...
#Install NextUtils
#cd ~/nexmon/utilities/nexutil/
#make && make install

#Uninstall WPA_Supplicant
#apt-get remove wpasupplicant

#Connect to AP
#nexutil -m0

#make the RPI02W load the modified driver after reboot
mv /lib/modules/5.10.63-v7+/kernel/drivers/net/wireless/broadcom/brcm80211/brcmfmac/brcmfmac.ko /lib/modules/5.10.63-v7+/kernel/drivers/net/wireless/broadcom/brcm80211/brcmfmac/brcmfmac.ko.orig
cp ~/nexmon/patches/bcm43436b0/9_88_4_65/nexmon/brcmfmac_5.10.y-nexmon/brcmfmac.ko /lib/modules/5.10.63-v7+/kernel/drivers/net/wireless/broadcom/brcm80211/brcmfmac/brcmfmac.ko
depmod -a

#reboot
reboot



