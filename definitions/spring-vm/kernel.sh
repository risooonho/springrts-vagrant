#!/bin/bash
source /etc/profile

# add required use flags and keywords
cat <<DATAEOF > "$chroot/etc/portage/package.use/kernel"
sys-kernel/gentoo-sources symlink
sys-kernel/genkernel -cryptsetup
DATAEOF

cat <<DATAEOF > "$chroot/etc/portage/package.accept_keywords/kernel"
dev-util/kbuild ~x86 ~amd64
DATAEOF

if [ "$arch" == "x86" ]; then

# hack to make kernel compile work on 32bit cpu with genkernel
# https://bugs.gentoo.org/show_bug.cgi?id=595432
cat << DATAEOF >> "$chroot/etc/portage/package.keywords/genkernel"
=sys-kernel/genkernel-3.5.0.2 **
DATAEOF

GENKERNEL_EXTRAPARAMS="${GENKERNEL_EXTRAPARAMS} --arch-override=x86"

fi

# get, configure, compile and install the kernel and modules
chroot "$chroot" emerge sys-kernel/gentoo-sources sys-kernel/genkernel app-portage/gentoolkit net-misc/dhcpcd

# add virtio modules to initrd
cat <<DATAEOF >> "$chroot/etc/genkernel.conf"
MODULES_KVM="virtio virtio_balloon virtio_ring virtio_pci virtio_blk virtio_net"
DATAEOF

chroot "$chroot" genkernel --install --symlink --no-gpg --no-luks --no-multipath --no-dmraid ${GENKERNEL_EXTRAPARAMS} all
