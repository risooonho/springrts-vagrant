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

chroot "$chroot" genkernel --install --symlink all
