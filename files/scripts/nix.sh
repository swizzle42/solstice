#!/usr/bin/env bash
set -oue pipefail

echo "Configuring Nix filesystem layout for Atomic target..."

# 1. Ensure systemd-tmpfiles directory exists
mkdir -p /usr/lib/tmpfiles.d

# 2. Tell systemd to create a writable directory in /var and bind-mount it over /nix on boot
# 'd' provisions the directory under /var if it's missing
# 'L+' creates the symbolic link/node target forcing /nix over to /var/nix
echo 'd /var/nix 0755 root root -' > /usr/lib/tmpfiles.d/nix-storage.conf
echo 'L+ /nix - - - - /var/nix' >> /usr/lib/tmpfiles.d/nix-storage.conf

# 3. Enable the layered nix-daemon service
systemctl enable nix-daemon
