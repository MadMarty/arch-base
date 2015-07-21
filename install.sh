#!/bin/bash

# exit script if return code != 0
set -e

# update arch repo list with us mirrors

echo 'Server = http://mirrors.abscission.net/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
echo 'Server = http://mirrors.acm.wpi.edu/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
echo 'Server = http://mirrors.advancedhosters.com/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
echo 'Server = http://mirrors.aggregate.org/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
echo 'Server = http://archlinux.surlyjake.com/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
echo 'Server = http://repo.atlantic.net/arch/$repo/os/$arch' > /etc/pacman.d/mirrorlist
echo 'Server = http://mirrors.cat.pdx.edu/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
echo 'Server = http://mirror.cc.columbia.edu/pub/linux/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
echo '#Server = http://cosmos.cites.illinois.edu/pub/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
echo '#Server = http://mirror.cs.pitt.edu/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
echo '#Server = http://mirror.es.its.nyu.edu/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
echo '#Server = http://mirror.gawsolutions.us/arch/$repo/os/$arch' > /etc/pacman.d/mirrorlist
echo '#Server = http://mirrors.gigenet.com/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
echo '#Server = http://mirror.grig.io/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
echo '#Server = http://www.gtlib.gatech.edu/pub/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
echo '#Server = http://mirror.ancl.hawaii.edu/linux/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist

# set locale
echo en_US.UTF-8 UTF-8 > /etc/locale.gen
locale-gen
echo LANG="en_US.UTF-8" > /etc/locale.conf

# add user "nobody" to primary group "users" (will remove any other group membership)
usermod -g users nobody

# add user "nobody" to secondary group "nobody" (will retain primary membership)
usermod -a -G nobody nobody

# setup env for user nobody
mkdir -p /home/nobody
chown -R nobody:users /home/nobody
chmod -R 775 /home/nobody
 
# update pacman and db
pacman -Sy --noconfirm
pacman -S pacman --noconfirm
pacman-db-upgrade

# refresh keys for pacman
mkdir -p /home/nobody/.gnupg/
touch /home/nobody/.gnupg/dirmngr_ldapservers.conf
pacman-key --refresh-keys

# update packages
pacman -Syu --ignore filesystem --noconfirm

# install supervisor
pacman -S supervisor --noconfirm

# cleanup
yes|pacman -Scc
rm -rf /usr/share/locale/*
rm -rf /usr/share/man/*
rm -rf /root/*
rm -rf /tmp/*
