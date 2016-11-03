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

cat <<DATAEOF > "/etc/profile.d/veewee.sh"

export stage3url=${stage3url}
export stage3file=${stage3file}

# these two (configuring the compiler) and the stage3 url can be changed to build a 32 bit system
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
export disk1=/dev/sda
DATAEOF
