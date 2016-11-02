#!/bin/bash
source /etc/profile

chroot "$chroot" /bin/bash <<DATAEOF

emerge crossdev
USE="cxx -fortran" crossdev --stable --target i686 --gcc 4.9.3 --libc 2.17

DATAEOF

mkdir -p "$chroot/usr/i686-pc-linux-gnu/etc/portage/package.use"
cat <<DATAEOF >  "$chroot/usr/i686-pc-linux-gnu/etc/portage/package.use/spring-static-buildslave"
sys-libs/zlib static-libs minizip
media-libs/devil static-libs opengl png jpeg tiff gif X
media-libs/giflib static-libs
media-libs/tiff static-libs -cxx
dev-libs/boost static-libs -python
media-libs/jpeg  static-libs
media-libs/libsdl2 -audio opengl static-libs X
media-libs/libvorbis static-libs
media-libs/libogg static-libs
media-libs/freetype static-libs autohinter
media-libs/glew static-libs
media-libs/libpng static-libs
x11-libs/libXcursor static-libs
app-arch/bzip2 static-libs
x11-libs/libXdmcp static-libs
x11-libs/libXrender static-libs
x11-libs/libX11 static-libs
x11-libs/libXfixes static-libs
x11-libs/libxcb static-libs
x11-libs/libXau static-libs
dev-libs/gmp static-libs
dev-libs/mpfr static-libs
dev-libs/mpc static-libs
net-misc/curl static-libs
dev-libs/openssl static-libs
dev-java/oracle-jdk-bin -X -fontconfig
sys-libs/libunwind static-libs
DATAEOF

cat <<DATAEOF >> "$chroot/usr/i686-pc-linux-gnu/etc/portage/make.conf"
PYTHON_TARGETS="python2_7"
USE="${USE} -pam -llvm -tools -uuid -kmod -classic -dri3 -egl -gallium -gbm -nptl -udev -fortran"
DATAEOF

mkdir -p "$chroot/usr/i686-pc-linux-gnu/etc/portage/package.mask"
cat <<DATAEOF > "$chroot/usr/i686-pc-linux-gnu/etc/portage/package.mask"
>sys-libs/glibc-2.17
DATAEOF

chroot "$chroot" /bin/bash <<DATAEOF
emerge-i686-pc-linux-gnu -va --nodeps
dev-libs/libffi \
=dev-lang/python-2.7.11-r2 \
dev-util/pkgconfig \
x11-misc/util-macros \
sys-libs/zlib \
app-arch/bzip2 \
dev-libs/boost \
media-libs/tiff \
media-libs/jpeg \
media-libs/libvorbis \
media-libs/freetype \
media-libs/libpng \
media-libs/openal \
dev-libs/openssl \
net-misc/curl \
=sys-libs/libunwind-0.99-r1 \
x11-libs/libXdmcp \
x11-libs/libXau \
=x11-libs/libxcb-1.10 \
x11-libs/libX11 \
x11-libs/libXrender \
x11-proto/fixesproto \
x11-libs/libXfixes \
x11-libs/libXcursor \
x11-libs/libdrm \
x11-proto/glproto \
x11-libs/libXext  \
x11-libs/libXdamage \
x11-proto/dri2proto \
media-libs/mesa \
media-libs/glu \
media-libs/glew \
media-libs/devil \
media-libs/libsdl2
DATAEOF

