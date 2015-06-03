#!/usr/bin/env bash

snddisk="/dev/sdb1"
mountpnt="/mnt/disk"

apt-get install -y parted
if [[ ! -e $snddisk ]]; then
    parted ${snddisk/1/} -- mklabel msdos mkpart primary 1 -1
    mkfs.ext4 $snddisk
    mkdir $mountpnt
    echo `blkid $snddisk |awk '{print$2}' |sed -e 's/"//g'` $mountpnt   ext4   defaults   0   0 >> /etc/fstab
    mount $snddisk $mountpnt
else
    echo "The second disk has been already attached!"
fi

