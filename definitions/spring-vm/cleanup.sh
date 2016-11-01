#!/bin/bash
source /etc/profile

# cleanup
chroot "$chroot" /bin/bash <<DATAEOF
# delete temp, cached and build artifact data
eclean -d distfiles
rm /tmp/*
rm -rf /var/log/*
rm -rf /var/tmp/*
rm /etc/profile.d/settings.sh

# clean root
rm -rf /root/.gem
#rm -rf /root/*

# skip all the news
eselect news read --quiet all

DATAEOF
