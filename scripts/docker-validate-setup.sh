#!/usr/bin/env bash
# 検証コンテナ内でリポジトリとホスト SSH を developer ホームへ同期する。
# パッケージ導入は Dockerfile 側で済ませる。
set -euo pipefail

rm -rf /home/developer/dotfiles-work
mkdir -p /home/developer/dotfiles-work /home/developer/.ssh
cp -a /mnt/dotfiles/. /home/developer/dotfiles-work/
cp -a /mnt/host-ssh/. /home/developer/.ssh/
chmod 700 /home/developer/.ssh
chmod 600 /home/developer/.ssh/id_* 2>/dev/null || true
chmod 644 /home/developer/.ssh/*.pub /home/developer/.ssh/known_hosts /home/developer/.ssh/config 2>/dev/null || true
chown -R developer:developer /home/developer
echo sync_ok
