require 'net/http'

#arch = "x86"
arch = "amd64"
template_uri   = "http://distfiles.gentoo.org/releases/#{arch}/autobuilds/latest-install-#{arch}-minimal.txt"
template_build = Net::HTTP.get_response(URI.parse(template_uri)).body.split(/\n/).last.split(/\ /)

iso_file = template_build.first.split(/\//).last,
iso_src= "http://distfiles.gentoo.org/releases/#{arch}/autobuilds/#{template_build.first}"

Veewee::Definition.declare({
  :cpu_count   => 2,
  :memory_size => '2048',
  :disk_size   => '20280',
  :disk_format => 'VDI',
  :hostiocache => 'off',
  :os_type_id  => 'Gentoo_64',
  :iso_file    => iso_file,
  :iso_src     => iso_src,
  :iso_download_timeout => 1000,
  :boot_wait => "10",
  :boot_cmd_sequence => [
    '<Wait>' * 2,
    'gentoo-nofb nokeymap<Enter>',
    '<Wait>' * 40,
    'echo Pe<Wait><Wait>rmitRoo<Wait>tLogin <Wait>yes>>/e<Wait>tc/ssh/<Wait>sshd_c<Wait>onfig<Enter><Wait>', # when typing to much at once, chars get lost
    'passwd<Enter><Wait><Wait>',
    'vagrant<Enter><Wait><Wait>',
    'vagrant<Enter><Wait><Wait><Wait>',
    'service<Wait> sshd <Wait>start<Enter>',
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
