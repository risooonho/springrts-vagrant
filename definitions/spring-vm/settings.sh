# settings that will be shared between all scripts

source .veewee_params

echo "arch: $arch"
echo "stage3url: $stage3url"
echo "stage3file: $stage3file"

case $arch in
	x86)
		build_arch="x86"
		build_proc="x86"
		chost=i686-pc-linux-gnu
	;;
	amd64)
		build_arch="amd64"
		build_proc="amd64"
		chost="x86_64-pc-linux-gnu"
	;;
	*)
	echo Unknown arch set: $arch
	exit 1
esac

ROOTDEVICE=""
for device in hda sda vda; do
	if [ -b /dev/$device ]; then
		ROOTDEVICE=/dev/$device
	fi
done

if [ -z "$ROOTDEVICE" ]; then
	echo "Couldn't detect ROOTDEVICE!"
	exit 1
fi


cat <<DATAEOF > "/etc/profile.d/veewee.sh"

export stage3url=${stage3url}
export stage3file=${stage3file}
export http_proxy=${http_proxy}
export https_proxy=${https_proxy}

# these two (configuring the compiler) and the stage3 url can be changed to build a 32 bit system
export arch="${arch}"
export accept_keywords="${arch}"
export chost="${chost}"

# timezone (as a subdirectory of /usr/share/zoneinfo)
export timezone="UTC"

# locale
export locale="en_US.utf8"

# chroot directory for the installation
export chroot=/mnt/gentoo

# number of cpus in the host system (to speed up make and for kernel config)
export nr_cpus=$(</proc/cpuinfo grep processor|wc -l)

# user passwords for password based ssh logins
export password_root=vagrant
export password_vagrant=vagrant

# the public key for vagrants ssh
export vagrant_ssh_key_url="https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub"
export disk1=$ROOTDEVICE
DATAEOF
