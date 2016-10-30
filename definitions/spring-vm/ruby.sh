#!/bin/bash
source /etc/profile

cat <<DATAEOF >> "$chroot/etc/portage/make.conf"
# use ruby 2.1
RUBY_TARGETS="ruby22"
DATAEOF

chroot "$chroot" /bin/bash <<DATAEOF
env-update && source /etc/profile
ACCEPT_KEYWORDS="~x86 ~amd64" emerge --autounmask-write ruby:2.2
eselect ruby set ruby22
DATAEOF
