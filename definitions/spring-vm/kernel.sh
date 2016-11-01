#!/bin/bash
source /etc/profile

# add required use flags and keywords
cat <<DATAEOF >> "$chroot/etc/portage/package.use/kernel"
sys-kernel/gentoo-sources symlink
sys-kernel/genkernel -cryptsetup
DATAEOF

cat <<DATAEOF >> "$chroot/etc/portage/package.accept_keywords/kernel"
dev-util/kbuild ~x86 ~amd64
DATAEOF

# get, configure, compile and install the kernel and modules
chroot "$chroot" emerge sys-kernel/gentoo-sources sys-kernel/genkernel app-portage/gentoolkit

# add virtio modules to initrd
cat <<DATAEOF >> "$chroot/etc/genkernel.conf"
MODULES_KVM="virtio virtio_balloon virtio_ring virtio_pci virtio_blk virtio_net"
DATAEOF

chroot "$chroot" genkernel --install --symlink all
