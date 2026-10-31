#!/usr/bin/env bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y ca-certificates curl git openssh-client sudo snapd dbus

id developer >/dev/null 2>&1 || useradd --create-home --shell /bin/bash developer
echo 'developer ALL=(ALL) NOPASSWD:ALL' >/etc/sudoers.d/developer
chmod 440 /etc/sudoers.d/developer

rm -rf /home/developer/dotfiles-work
mkdir -p /home/developer/dotfiles-work /home/developer/.ssh
cp -a /mnt/dotfiles/. /home/developer/dotfiles-work/
cp -a /mnt/host-ssh/. /home/developer/.ssh/
chmod 700 /home/developer/.ssh
chmod 600 /home/developer/.ssh/id_* 2>/dev/null || true
chmod 644 /home/developer/.ssh/*.pub /home/developer/.ssh/known_hosts /home/developer/.ssh/config 2>/dev/null || true
chown -R developer:developer /home/developer

systemctl enable --now snapd.socket snapd.service
ln -sfn /var/lib/snapd/snap /snap

for _ in $(seq 1 60); do
  if snap version >/dev/null 2>&1; then
    echo snap_ready
    snap version
    exit 0
  fi
  sleep 2
done

echo 'snapd did not become ready' >&2
exit 1
