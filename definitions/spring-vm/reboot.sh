#!/bin/bash
source /etc/profile

# as we reboot in the next step into chroot, remove chroot from env
sed -i '/chroot/d' $chroot/etc/profile.d/veewee.sh

# copy dhcpcd lease file to get same ip after reboot
cp /var/lib/dhcpcd/dhcpcd-eth0.lease $chroot/var/lib/dhcpcd/dhcpcd-eth0.lease

/sbin/reboot
ps aux | grep sshd | grep -v grep | awk '{print $2}' | xargs kill
