#copy image
```
dd if=~/miob.img of=/dev/mmcblk0 status=progress
sync
```
plug sdcard into raspberry. And turn on

regenerate password, machine-id, hostname, ssh host keys
```
$ ssh pi@miob-X.<DOMAIN>
# passwd
# rm /etc/machine-id
# systemd-machine-id-setup
# hostnamectl set-hostname miob-<NO>
# rm -v /etc/ssh/ssh_host_*
removed '/etc/ssh/ssh_host_dsa_key'
removed '/etc/ssh/ssh_host_dsa_key.pub'
removed '/etc/ssh/ssh_host_ecdsa_key'
removed '/etc/ssh/ssh_host_ecdsa_key.pub'
removed '/etc/ssh/ssh_host_ed25519_key'
removed '/etc/ssh/ssh_host_ed25519_key.pub'
removed '/etc/ssh/ssh_host_rsa_key'
removed '/etc/ssh/ssh_host_rsa_key.pub'
# dpkg-reconfigure openssh-server
# systemctl restart ssh
# reboot
```
