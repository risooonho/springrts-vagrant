#!/bin/bash
source /etc/profile

chroot "$chroot" /bin/bash <<DATAEOF

emerge crossdev

USE="cxx -fortran" crossdev --stable --target i686 --gcc 4.9.3 --libc 2.17

DATAEOF

