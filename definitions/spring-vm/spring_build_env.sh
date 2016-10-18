#!/bin/bash
source /etc/profile

mkdir -p "$chroot/etc/portage/package.use/"
cat <<DATAEOF >> "$chroot/etc/portage/package.use/spring-static-buildslave"
sys-libs/zlib static-libs minizip
media-libs/devil static-libs opengl png jpeg tiff gif X
media-libs/giflib static-libs
media-libs/tiff static-libs
dev-libs/boost static-libs python
media-libs/jpeg  static-libs
media-libs/libsdl2 -sound opengl static-libs X
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
net-misc/curl static-libs
dev-libs/openssl static-libs
sys-libs/libunwind static-libs
DATAEOF


mkdir -p "$chroot/etc/portage/env/"
cat <<DATAEOF >> "$chroot/etc/portage/env/spring-static-buildslave"
CFLAGS="${CFLAGS} -fPIC"
CXXFLAGS="${CXXFLAGS} -fPIC"
LDFLAGS="${LDFLAGS} -fPIC"
DATAEOF


mkdir -p "$chroot/etc/portage/package.env/"
cat <<DATAEOF >> "$chroot/etc/portage/package.env/spring-static-buildslave"
sys-libs/zlib spring-static-buildslave
media-libs/devil spring-static-buildslave
media-libs/giflib spring-static-buildslave
media-libs/tiff spring-static-buildslave
dev-libs/boost spring-static-buildslave
media-libs/jpeg spring-static-buildslave
media-libs/libsdl2 spring-static-buildslave
media-libs/libvorbis spring-static-buildslave
media-libs/freetype spring-static-buildslave
media-libs/glew spring-static-buildslave
media-libs/libpng spring-static-buildslave
sys-devel/gcc spring-static-buildslave
x11-libs/libXcursor spring-static-buildslave
DATAEOF

cat <<DATAEOF >> "$chroot/etc/portage/package.use/jdk"
>=x11-libs/cairo-1.14.6 X
>=x11-libs/gdk-pixbuf-2.34.0 X
DATAEOF

# install packages
chroot "$chroot" /bin/bash <<DATAEOF
emerge sys-libs/zlib media-libs/devil dev-libs/boost media-libs/jpeg media-libs/libsdl2 \
media-libs/libvorbis media-libs/freetype media-libs/glew media-libs/libpng x11-libs/libXcursor \
app-arch/bzip2 x11-libs/libXdmcp x11-libs/libXrender x11-libs/libX11 x11-libs/libXfixes \
x11-libs/libxcb x11-libs/libXau net-misc/curl sys-libs/libunwind virtual/jdk app-arch/p7zip media-libs/openal
DATAEOF




