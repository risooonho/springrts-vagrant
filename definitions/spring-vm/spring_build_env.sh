#!/bin/bash
source /etc/profile

mkdir -p "$chroot/etc/portage/package.use"
cat <<DATAEOF > "$chroot/etc/portage/package.use/spring-static-buildslave"
sys-libs/zlib static-libs abi_x86_32 minizip
media-libs/devil static-libs abi_x86_32 opengl png jpeg tiff gif X
media-libs/giflib static-libs abi_x86_32
media-libs/tiff static-libs abi_x86_32
dev-libs/boost static-libs abi_x86_32 python
dev-libs/expat static-libs abi_x86_32
media-libs/libjpeg-turbo static-libs abi_x86_32
media-libs/libsdl2 static-libs abi_x86_32 -sound opengl X
media-libs/libvorbis static-libs abi_x86_32
media-libs/libogg static-libs abi_x86_32
media-libs/freetype static-libs abi_x86_32 autohinter
media-libs/glew static-libs abi_x86_32
media-libs/libpng static-libs abi_x86_32
media-libs/fontconfig static-libs abi_x86_32
x11-libs/libXcursor static-libs abi_x86_32
app-arch/bzip2 static-libs abi_x86_32
x11-libs/libXdmcp static-libs abi_x86_32
x11-libs/libXrender static-libs abi_x86_32
x11-libs/libX11 static-libs abi_x86_32
x11-libs/libXfixes static-libs abi_x86_32
x11-libs/libxcb static-libs abi_x86_32
x11-libs/libXau static-libs abi_x86_32
net-misc/curl static-libs abi_x86_32
dev-libs/openssl static-libs abi_x86_32 bindist
sys-libs/libunwind static-libs abi_x86_32
DATAEOF

mkdir -p "$chroot/etc/portage/package.mask"
cat <<DATAEOF > "$chroot/etc/portage/package.mask/spring-static-buildslave"
>=sys-libs/libunwind-1.0
DATAEOF

mkdir -p "$chroot/etc/portage/env"
cat <<DATAEOF > "$chroot/etc/portage/env/spring-static-buildslave"
CFLAGS="${CFLAGS} -fPIC"
CXXFLAGS="${CXXFLAGS} -fPIC"
LDFLAGS="${LDFLAGS} -fPIC"
DATAEOF


mkdir -p "$chroot/etc/portage/package.env"
cat <<DATAEOF > "$chroot/etc/portage/package.env/spring-static-buildslave"
sys-libs/zlib spring-static-buildslave
media-libs/devil spring-static-buildslave
media-libs/giflib spring-static-buildslave
media-libs/tiff spring-static-buildslave
dev-libs/boost spring-static-buildslave
media-libs/libjpeg-turbo spring-static-buildslave
media-libs/libsdl2 spring-static-buildslave
media-libs/libvorbis spring-static-buildslave
media-libs/freetype spring-static-buildslave
media-libs/glew spring-static-buildslave
media-libs/libpng spring-static-buildslave
media-libs/fontconfig spring-static-buildslave
sys-devel/gcc spring-static-buildslave
x11-libs/libXcursor spring-static-buildslave
DATAEOF

cat <<DATAEOF > "$chroot/etc/portage/package.use/jdk"
>=x11-libs/cairo-1.14.6 X
>=x11-libs/gdk-pixbuf-2.34.0 X
DATAEOF

# install packages
chroot "$chroot" /bin/bash <<DATAEOF
emerge sys-libs/zlib media-libs/devil dev-libs/boost media-libs/libjpeg-turbo media-libs/libsdl2 \
media-libs/libvorbis media-libs/freetype media-libs/glew media-libs/libpng x11-libs/libXcursor \
app-arch/bzip2 x11-libs/libXdmcp x11-libs/libXrender x11-libs/libX11 x11-libs/libXfixes \
x11-libs/libxcb x11-libs/libXau net-misc/curl dev-java/icedtea-bin app-arch/p7zip media-libs/openal \
dev-libs/expat media-libs/fontconfig sys-libs/libunwind
DATAEOF
