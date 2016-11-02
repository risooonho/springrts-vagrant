#!/bin/bash
source /etc/profile


chroot "$chroot" /bin/bash <<DATAEOF
emerge dev-util/buildbot-slave dev-util/ninja dev-util/ccache
useradd -s /bin/false -d /home/buildbot -m buildbot
eselect python set python2.7
DATAEOF

cat <<DATAEOF > "$chroot/etc/conf.d/buildslave"
# Path to the build slave's basedir.
BASEDIR="/home/buildbot"

# User account for the buildslave.
# The basedir should be owned by this user.
USERNAME="buildbot"

# Extra options passed to twistd.
TWISTD_OPTS=""
DATAEOF
