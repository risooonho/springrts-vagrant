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
media-libs/tiff static-libs
dev-libs/boost static-libs python
dev-libs/expat static-libs
media-libs/libjpeg-turbo  static-libs
media-libs/libsdl2 -sound opengl static-libs X
media-libs/libvorbis static-libs
media-libs/libogg static-libs
media-libs/freetype static-libs autohinter
media-libs/glew static-libs
media-libs/libpng static-libs
media-libs/fontconfig static-libs
x11-libs/libXcursor static-libs
app-arch/bzip2 static-libs
x11-libs/libXdmcp static-libs
x11-libs/libXrender static-libs
x11-libs/libX11 static-libs
x11-libs/libXfixes static-libs
x11-libs/libxcb static-libs
x11-libs/libXau static-libs
net-misc/curl static-libs
dev-libs/openssl static-libs
sys-libs/libunwind static-libs
DATAEOF

cat <<DATAEOF >> "$chroot/usr/i686-pc-linux-gnu/etc/portage/make.conf"
PYTHON_TARGETS="python2_7"
USE="${USE} -pam -llvm -tools -uuid -kmod -classic -dri3 -egl -gallium -gbm -nptl -udev -fortran"
DATAEOF

mkdir -p "$chroot/usr/i686-pc-linux-gnu/etc/portage/package.mask"
cat <<DATAEOF > "$chroot/usr/i686-pc-linux-gnu/etc/portage/package.mask/spring-static-buildslave"
>sys-libs/glibc-2.17
>=dev-lang/python-2.8
>=sys-libs/libunwind-1.0
DATAEOF

chroot "$chroot" /bin/bash <<DATAEOF
ARCH=x86 emerge dev-util/pkgconfig x11-misc/util-macros
ARCH=x86 emerge-i686-pc-linux-gnu \
sys-libs/zlib media-libs/devil dev-libs/boost media-libs/libjpeg-turbo media-libs/libsdl2 \
media-libs/libvorbis media-libs/freetype media-libs/glew media-libs/libpng x11-libs/libXcursor \
app-arch/bzip2 x11-libs/libXdmcp x11-libs/libXrender x11-libs/libX11 x11-libs/libXfixes \
x11-libs/libxcb x11-libs/libXau net-misc/curl dev-java/icedtea-bin app-arch/p7zip media-libs/openal \
dev-libs/expat media-libs/fontconfig sys-libs/libunwind
DATAEOF

