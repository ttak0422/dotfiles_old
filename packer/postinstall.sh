#/bin/sh

packer_http=$(cat .packer_http)

nix-env --delete-generations old
nix-collect-garbage -d

# Zero out the disk (for better compression)
dd if=/dev/zero of=/EMPTY bs=1M
rm -rf /EMPTY

# Remove install ssh key
rm -rf /root/.ssh /root/.packer_http