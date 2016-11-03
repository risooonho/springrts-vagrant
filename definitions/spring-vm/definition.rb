require 'net/http'

arch = "x86"
#arch = "amd64"
template_uri   = "http://distfiles.gentoo.org/releases/#{arch}/autobuilds/latest-install-#{arch}-minimal.txt"
template_build = Net::HTTP.get_response(URI.parse(template_uri)).body.split("\n").last.split(" ").first

filename = template_build.split("/").last
url = "http://distfiles.gentoo.org/releases/#{arch}/autobuilds/#{template_build}"

# uncomment / adjust for "offline" mode
#filename = "install-x86-minimal-20161101.iso"
#url = "http://distfiles.gentoo.org/releases/x86/autobuilds/20161101/install-x86-minimal-20161101.iso"

# get url for gentoo stage3 downloada
if arch == "amd64"
	template_uri = "http://distfiles.gentoo.org/releases/#{arch}/autobuilds/latest-stage3-#{arch}.txt"
else
	template_uri = "http://distfiles.gentoo.org/releases/#{arch}/autobuilds/latest-stage3-i686.txt"
end

template_build = Net::HTTP.get_response(URI.parse(template_uri)).body.split("\n").last.split(" ").first
stage3url = "http://distfiles.gentoo.org/releases/#{arch}/autobuilds/#{template_build}"
stage3file = template_build.split("/").last

Veewee::Definition.declare({
  :cpu_count   => 2,
  :memory_size => '2048',
  :disk_size   => '20280',
  :disk_format => 'VDI',
  :hostiocache => 'off',
  :os_type_id  => 'Gentoo_64',
  :iso_file    => filename,
  :iso_src     => url,
  :iso_download_timeout => 1000,
  :boot_wait => "10",
  :boot_cmd_sequence => [
    '<Wait>' * 2,
    'gentoo-nofb nokeymap dosshd passwd=vagrant<Enter>',
  ],
#  :kickstart_port    => '7122',
#  :kickstart_timeout => 300,
#  :kickstart_file    => '',
  :ssh_login_timeout => '10000',
  :ssh_user          => 'root',
  :ssh_password      => 'vagrant',
  :ssh_key           => '',
  :ssh_host_port     => '7222',
  :ssh_guest_port    => '22',
  :sudo_cmd          => "cat '%f'|su -",
  :shutdown_cmd      => 'shutdown -hP now',
  :params => {
     :arch => arch,
     :stage3url => stage3url,
     :stage3file => stage3file,
  },
  :postinstall_files => [
    'settings.sh',
    'base.sh',
    'kernel.sh',
    'git.sh',
#    'kvm-guest-tools.sh',
#    'virtualbox.sh',
    'vagrant.sh',
#    'ruby.sh',
#    'add_chef.sh',
#    'add_puppet.sh',
    'add_vim.sh',
    'cron.sh',
    'syslog.sh',
    'grub.sh',
    'spring_build_env.sh',
#    'spring_build_env_x32.sh',
    'spring_buildbot.sh',
#    'wipe_sources.sh',
#    'cleanup.sh',
#    'zerodisk.sh',
    'reboot.sh'
  ],
  :postinstall_timeout => 10000
})
