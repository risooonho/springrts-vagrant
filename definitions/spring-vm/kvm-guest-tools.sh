#!/bin/bash
source /etc/profile

#install qemu guest tools (used for kvm)
chroot "$chroot" /bin/bash <<DATAEOF
emerge app-emulation/qemu-guest-agent
rc-update add qemu-guest-agent default
service qemu-guest-agent start
DATAEOF

