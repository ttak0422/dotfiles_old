#/bin/sh

packer_http=$(cat .packer_http)

nix-env --delete-generations old
nix-collect-garbage -d

# Zero out the disk (for better compression)
dd if=/dev/zero of=/EMPTY bs=1M
rm -rf /EMPTY

# vagrant
mkdir -pm 700 /home/vagrant/.ssh
curl -sf "$packer_http/vagrant.pub" > /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh

# Remove install ssh key
rm -rf /root/.ssh /root/.packer_http